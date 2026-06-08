Return-Path: <netdev+bounces-296778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZJ1gOuRQJ2r2ugIAu9opvQ
	(envelope-from <netdev+bounces-296778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:31:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D54265B2C6
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:31:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ToAePlCo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296778-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296778-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C1DB302D62F
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B088342CB1;
	Mon,  8 Jun 2026 23:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A1340412
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961487; cv=none; b=qkhvQwNObUP2rF+BGeEV+58hg8P/W0Q3aY7/vO+e+SiMQsjYJ94xvvx6YDP5rZMI0nkbkwkIbxybO7O+J1uDsKM50lHV7Jizd2oBZFhLy0wj1/HpWcODSKownW+M/9yk9w2tuw/V8/DRuyaZp4GUJjROnhSDTx095+FsNoAP1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961487; c=relaxed/simple;
	bh=odcXxIgOYTFkqPGDiY8mrTgrRpKn40ryt94ycouK5H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B613sFVF/pT5Yg4c/JPQKPTugRLboih4SH32inNwa0R6Np8JeYuS5TzB0HTXgFZULeYRXjk8uQs8X7Y4dwi+NqG087lQ+IayaZuWb/ba5mfq78m+DGj14JAvGgnHYD5pknLi21RPrGeHb9+aFsSVyFLRz4ZP/TgDlbsIEUDAd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToAePlCo; arc=none smtp.client-ip=74.125.224.45
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6603d54b317so572813d50.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961485; x=1781566285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq0yFIJstkuP2f/7RvLboKcWVQrHMIMnRY3urBHubEA=;
        b=ToAePlCocHXKYD8qwGvU0FnCsXzKtGlH12oG67VAC8IQnhVfZ5ZQKLNpneMlLWaKQu
         twtJobM0ztUHUi62vf3H/W5vi7hfATgGrd7EIVBFu10nlG8+a5obhnKuZxJodTq59ST2
         LkyzT+ncHkwyJcFxdVX7PHgNZAtvJqjWANZnKJyKAPgD2toYYcHzHxACBf+omEuDFTIl
         XoZnPIMkptAtoYIUBoK2MDfq7Knf8dQ+4Rc0AB6R7fxsAVBvR+lGAjEVYnNyq7P8iVeU
         Tc7KH/T/kb3ugBw61sGX8mXZ2dl1SWof8v7Rbhbx2QTv4dRMu2W2oHMuTtcb12bI6ZjT
         1ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961485; x=1781566285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aq0yFIJstkuP2f/7RvLboKcWVQrHMIMnRY3urBHubEA=;
        b=Twwh3cWKx4I/dksd/7m2z/GC6Ga7E0G7kQIJh0lKBmrdKi9AEJzOWJdFDXMMOwj3CQ
         rtFEFgP2NIZ0p11V4vEsWpEnvQJWfVgFDigo6ouv0MfidPgErHdQhlmXiVdcHSdXKzpN
         BEORbdxpAlAm+QKUXfmPmKWqh9aFODCrFat7KcnSjIZ6nXtl6Td3tNgvFDMm2Wi75u3t
         FEUSG2HGvK3y+t4zRVVCJ9QEAFAnG1317d26/vs1Q721v7UA3ERYbetwb/CnCpQFsd0R
         YcPJcUy0cbqtz3yzR+u4OWQY3INno/TzFH3PdMOHi/Ofdhnw6x9TwJ8n0ixI+J0VQyfC
         3hMg==
X-Gm-Message-State: AOJu0Yxon6zrNuiNwUBX/UIrij+ErBAq8VgEHKGVF6AUc0rsM3lQIS+Z
	plUwgN65SRV5Q7blv9pNn4Jl3SX19d1xH4tK6kxGUCilPfr0yFUDGbPuXzo6Kg==
X-Gm-Gg: Acq92OHCfVFLo9uolzwcFjj2Nb+5lg6UsN6ziNzQWr0uNKEUUznne0Yz43jC0g5CJVt
	obqPW/y9/M+B99YBqeFcTsriQD+VblBa0RT2jkPHpRa8fVFoo1K+Fk8ceLBSfm0DPktzQ2XOPDy
	pQy2C+RGvPooUf8Uw3MaFr37b8ijcF7lwwE1lDYk7SH+2rb55th+Ix2/elbb7NidF8i/bVPKefn
	FFL9GfA3w8Wn+Jy7yK+pi4y5lwlq3s09MmtDGc7kaOzc/hbw/uHIEEXFyhhKBa+NhjIJg+AhwqR
	Rl3j5DtAgUfPoWnAJKJunjvYs/Lx2PvqJD1xc7pzuCVrQOFZKw0FQlpVNfSmNuMEOBmGy/JIHc3
	7s+RM4f7uXrndXCuy5bTyJzGr9pjXPV3n/Vo64Js/c0v1FGB2cpp339l9573VjmRYKA+asOipBY
	R/9Fj3b45b/lZ04+kDtPZ8A6luV2uYdlhnUA==
X-Received: by 2002:a05:690c:c4f1:b0:7ba:f0d0:5e9b with SMTP id 00721157ae682-7ed0b1a0c14mr106736437b3.2.1780961484927;
        Mon, 08 Jun 2026 16:31:24 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea235885d1sm89509667b3.26.2026.06.08.16.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:31:24 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v16 net-next 05/10] selftests/net: add _find_bpf_obj() to search hw/ for BPF objects
Date: Mon,  8 Jun 2026 16:31:13 -0700
Message-ID: <20260608233118.2694144-6-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
References: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296778-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D54265B2C6

From: Wei Wang <weibunny@fb.com>

Add _find_bpf_obj() helper to NetDrvContEnv that searches the test
directory first, then falls back to the hw/ subdirectory. This allows
tests outside drivers/net/hw/ (e.g. psp.py in drivers/net/) to find
BPF objects built in the hw/ directory.

Update _attach_bpf() and _attach_primary_rx_redirect_bpf() to use
_find_bpf_obj() for BPF object discovery.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 .../selftests/drivers/net/lib/py/env.py       | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 2cc78b8a2152..9ccea3b44800 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -512,10 +512,19 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return map_id
         raise Exception(f"Failed to find .bss map for prog {prog_id}")
 
+    def _find_bpf_obj(self, name):
+        bpf_obj = self.test_dir / name
+        if bpf_obj.exists():
+            return bpf_obj
+        bpf_obj = self.test_dir / "hw" / name
+        if bpf_obj.exists():
+            return bpf_obj
+        return None
+
     def _attach_bpf(self):
-        bpf_obj = self.test_dir / "nk_forward.bpf.o"
-        if not bpf_obj.exists():
-            raise KsftSkipEx("BPF prog not found")
+        bpf_obj = self._find_bpf_obj("nk_forward.bpf.o")
+        if not bpf_obj:
+            raise KsftSkipEx("BPF prog nk_forward.bpf.o not found")
 
         if self._tc_ensure_clsact():
             self._tc_clsact_added = True
@@ -535,9 +544,9 @@ class NetDrvContEnv(NetDrvEpEnv):
 
     def _attach_primary_rx_redirect_bpf(self):
         """Attach BPF redirect program on the primary netkit ingress."""
-        bpf_obj = self.test_dir / "nk_primary_rx_redirect.bpf.o"
-        if not bpf_obj.exists():
-            raise KsftSkipEx("Primary RX redirect BPF prog not found")
+        bpf_obj = self._find_bpf_obj("nk_primary_rx_redirect.bpf.o")
+        if not bpf_obj:
+            raise KsftSkipEx("nk_primary_rx_redirect.bpf.o not found")
 
         if self._tc_ensure_clsact(self._nk_host_ifname):
             self._primary_rx_redirect_clsact_added = True
-- 
2.52.0


