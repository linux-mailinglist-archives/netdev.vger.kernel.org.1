Return-Path: <netdev+bounces-281379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N0tBTd072kcBgEAu9opvQ
	(envelope-from <netdev+bounces-281379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:35:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0CC47477E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AE59302260A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857B27B357;
	Mon, 27 Apr 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="E60OZ9Au"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5025FA05;
	Mon, 27 Apr 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300257; cv=none; b=AUuheNQklOvEsjBgxrC6J4mOQwnCT/NXPH9Z8UBKKRzj4BaFIJWDMz8DWHCFSmGdOruPGfrGX2nymDzyu3UYTACOmfKPjps43pNtqzfzW4+ahH5IYrWjPeQQoIhiAP1+GWOPqH5SKOmar+E/G76Ry3KXXeYk9DMdGSNVwcDCzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300257; c=relaxed/simple;
	bh=7C4AbpIu+P9UrWUnbpxkZXIquXi8ED0PTqMLY8cdaGU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EGnwZVJJm3GtyuRbXIHAbKs7MlCHFK4zo8haeK03++iQXEHiigOx5sAnenMK/5e5GKrtgIHvVufPH3r5BgH6UjpdlSYMEyXs2Tp8aoAZ2UlcYGPOQQUEKCswA1dUO5NbmRvgw1+8oHdrl/d40tU88Ukz6eTAyAFiVyY3gllQCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=E60OZ9Au; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=f8Ufe+9Z5B1oyMFVF/eK8ivT3EkZAHozTLAdDiuw/g4=; b=E60OZ9AubVYLoVyKBGjBe7CglQ
	BIpsU5vMtiBK5yypsTMSLtRhgUjs/mIG9+y2GaGj09kPBhNC+ohBRSKCrlvbGnaLDMDtmcS0aem9T
	JfQf1mHef6r8WlzIlTpLBpzfz40jWH7O+lxLSjDIoGDDa85AN7Z2Q1zJ/q1ZE67m78P04nodizPLV
	RVE8bMNe802ZCwIk7cTL/B6emr7iH67yeorrcyWHcJu7ueLKLHMDXJ8+EAQFOLsn4e0cOwH4CpvfP
	gPWKZVNWI6/esvjOVpfSIHPCu8R26aIN5CJm44HK031Kt6603N1WfZBKusC+oEsaWlGVgAfn7YquE
	Dw+6SIdw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHMz2-005Xwf-0q;
	Mon, 27 Apr 2026 14:30:49 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v2 0/4] netconsole: configfs store callback fixes
Date: Mon, 27 Apr 2026 07:30:34 -0700
Message-Id: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAApz72kC/22NQQ6CMBBFr9LM2hoYUGxX3sMQ0pYRxpjWtJVoC
 Hc3oEu3/7+8N0OiyJRAixkiTZw4eNACdwLcaPxAknvQArDAY1EjSk/ZBZ/CnTrD3ZVflCTWB6W
 qqjGN6mEn4BFpO0CLC3jK0H7H9LQ3cnn1rdjIKYf43tpTucG/TPU3M5WykArtyTY9KYPu3JNl4
 /chDtAuy/IB62vLL84AAAA=
X-Change-ID: 20260422-netconsole_ai_fixes-24599337a79d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Keiichi Kii <k-keiichi@bx.jp.nec.com>, Satyam Sharma <satyam@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wood <thepacketgeek@gmail.com>, asantostc@gmail.com, 
 gustavold@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=leitao@debian.org;
 h=from:subject:message-id; bh=7C4AbpIu+P9UrWUnbpxkZXIquXi8ED0PTqMLY8cdaGU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp73MSb8Cvsl+jebSCr/xTpotBh3ht/VeRHUDed
 YfyXIMtefuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCae9zEgAKCRA1o5Of/Hh3
 bSeMD/wJ2fzZjnpYI4c+UNnGEH31DOTy4dCwVue4OLW/L3h9c9lWVXqgl0rO+QL70o/jzJ6I0Av
 BDMq4BCZyIYwpuoZq5Jbm5EkAFyqGmLD/R68lvnamLyP3GNr9B+VkDgHxieKkYFOcINYbe4KX61
 qCl0k4gDzGzSxXnKND90HR+Nfg2STMFSpm4h1/9v7923v4ZJWv4aq4gagXIlV2kWzys0fG9Anbp
 BFchK8K7fCDMs2UFK81iQzfHTMUgKuO/cBAGDV7uck5B6fuFph9y/7RfnCa0eqFySWMvcoUJ17p
 b1RVNkmCnGMRAxEV8/2O0nkDNA/fGLYn1paMpZUU3ZX4yRliW4LKun5JTt9HH61vv9gswJ0sIGf
 BOUiMEri4cisVvAypOSRD1cp+0UuVsjpg7KbuuJ25i256HUsGBvlCNGYtb9e+2xRaRLungyaJ9N
 z74JRx/O0+KsDJeC2UWu+XeJ9jah1HXa3SNdmuZCP1otXIeGqyDYKn8fFvMBaKJHw2B2vxhLgQU
 pDATOL6uxTPp8F/TvNG0bju1jZ4bc3URaELXs7kIJ2wRKX77ru/UiAmuNEbCBpHajYuCT5Po9H0
 blUKpzZ/GWQlmlwMvFUQ7CHOhlBpcw3GwSlH0dnLRA8lDKZGWLhRh33G/aqaZJX40pvbRS5xdQ4
 3D9bgjwL1sMRiVg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 7E0CC47477E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281379-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

V2 for issues in netconsole's configfs store callbacks.

There are still some changes I want to make, such as, having the dynamic
lock when reading from configfs (_show() callbacks), wich will solve
other issues, but I will keep it for later.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- dev_name_store: strip optional trailing newline before length check
  so 15-char ifnames written via echo aren't rejected (Simon, Sashiko)
- userdatum_value_store: snapshot and restore udm->value on
  update_userdata() failure to keep visible state in sync with the live
  payload (Simon/Sashiko)
- Link to v1: https://patch.msgid.link/20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org

---
Breno Leitao (4):
      netconsole: return count instead of strnlen(buf, count) from store callbacks
      netconsole: avoid clobbering userdatum value on truncated write
      netconsole: propagate device name truncation in dev_name_store()
      netconsole: restore userdatum value on update_userdata() failure

 drivers/net/netconsole.c | 49 +++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)
---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260422-netconsole_ai_fixes-24599337a79d

Best regards,
--  
Breno Leitao <leitao@debian.org>


