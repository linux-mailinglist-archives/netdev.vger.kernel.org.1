Return-Path: <netdev+bounces-277044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNvnLkTD12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:18:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B43CC82A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99A5C30055DA
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A21236BCF2;
	Thu,  9 Apr 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ETWY7FRZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722228FFFB;
	Thu,  9 Apr 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747903; cv=none; b=IYsvfDQlvvefge94MMFZdnCrcUNnzWgCShlJwxwo2HBWFqq0yHvK9aXOdJ5SS5gfST3GPP9+MAioycG4+zwS4W/o9Z/HF6Sa8PEq2srwquGozH0OeT2msjTQo22xd0BO/uDsAnc6/K+5JG5U6tEUFIgGcHQrHZs5h86tt5vVQ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747903; c=relaxed/simple;
	bh=COPLr3j3eltzdDcRfB/ZCPTVTVfPv3jxkW/ugyXwMBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzWhBtFTPWmJAlapDV82CK0YT/Ln4a1CtAIr39PpcxZIG/KF45k/ZHPIRYdx2l316/Pkl+OVSQzw+SBzxLUb+hE9v5i8yE/v0XOVlZk/VEu/rz8qaQelWxuL3lOTF1aBERgQ7gQwQ5HpuYLYh/00fSyHHolktlyi6Mc04Zyp3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ETWY7FRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41BAC4CEF7;
	Thu,  9 Apr 2026 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775747903;
	bh=COPLr3j3eltzdDcRfB/ZCPTVTVfPv3jxkW/ugyXwMBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETWY7FRZ+hhtUnu8lsJnY9xyRyFXV7RuyVddIQUQGS4isqJf1NyjUmgFppL2/s22O
	 Xg1WbJXu+XulMkJnGDvpDwXrnZ/Hel8pQVKOK+RxcueqGmaz5YrBPr79LNZMNvKFrU
	 puzj+nHkiNW2rxv9KEQDxru7271jGofmvr+6ASks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thierry Escande <thierry.escande@linux.intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	stable <stable@kernel.org>
Subject: [PATCH net 2/2] NFC: digital: Bounds check Felica response before sensf_res memcpy
Date: Thu,  9 Apr 2026 17:18:15 +0200
Message-ID: <2026040913-rearrange-unseeing-fa85@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040913-figure-seducing-bd3f@gregkh>
References: <2026040913-figure-seducing-bd3f@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 50
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=COPLr3j3eltzdDcRfB/ZCPTVTVfPv3jxkW/ugyXwMBM=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnXD5vNjri/vz9UaN/XrLCKOWwbj/S1WmxfxHjUbU+Ec qL31xnvOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAinPcY5kqVTdoZN7edzT9b Nj3b7Xi902qRbIb5iT377qw6cuxD8gOmOS/XL5gi/PCkFQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277044-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,davemloft.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: BD6B43CC82A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A malicious NFC peer can send a SENSF_RES that is longer than the
NFC_SENSF_RES_MAXSIZE (18 byte) sensf_res field in the onstack struct
nfc_target.  digital_in_recv_sensf_res() validates that the response is
at least DIGITAL_SENSF_RES_MIN_LENGTH bytes but applies no upper bound
before memcpy(target.sensf_res, sensf_res, resp->len) is called,
allowing a stack buffer overflow with attacker-controlled length and
content.

Commit e329e71013c9 ("NFC: nci: Bounds check struct nfc_target arrays")
fixed identical missing checks for the same target->sensf_res field on
the NCI path; the Digital Protocol path was never patched.

Fix this all up by just rejecting responses that exceed
NFC_SENSF_RES_MAXSIZE.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Thierry Escande <thierry.escande@linux.intel.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Fixes: 8c0695e4998d ("NFC Digital: Add NFC-F technology support")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/digital_technology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index ae63c5eb06fa..e18bdb231352 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -774,6 +774,11 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	skb_pull(resp, 1);
 
+	if (resp->len > NFC_SENSF_RES_MAXSIZE) {
+		rc = -EPROTO;
+		goto exit;
+	}
+
 	memset(&target, 0, sizeof(struct nfc_target));
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
-- 
2.53.0


