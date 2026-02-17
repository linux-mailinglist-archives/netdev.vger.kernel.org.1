Return-Path: <netdev+bounces-258970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP+gCQENlGn4/QEAu9opvQ
	(envelope-from <netdev+bounces-258970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 07:38:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAA14902D
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 07:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D14CC3010500
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 06:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EDC283159;
	Tue, 17 Feb 2026 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMZCH+2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B41DE3B5
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310334; cv=none; b=JpQ6gF+ZmOu/6ZaYiFtkJ/vM+DCzjkXsMPMU7bc31dLjbcXdyJFITyKLU6i7O0/0RIWvbiQ1KaCYRPsDBoESMZTzoywqsUJ2YRGPbLa0U56RlW1r4FH1SEpm+d0n2Nhu0N4rp2k+JRBKTWV698LDmW7ZERhWmMJxOU+mkzSy7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310334; c=relaxed/simple;
	bh=F3CVpN/hgYqoWzqwicIcToM8NyrUug2xcBmrs3gvW08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7iI/iED+QwmBXMLcs9HuJBtX59dYmHUWnVPzX+rHENJrqoVrMDcgcY5k5wuYgx6yVKEky/W/33GTgaCojgdguKg6/icrRshxW8tw4m6YZlWX+IfeyeZdTgXhVWXTtC59jKyjn6BtupBGXTzI1KFydsygjH/pgQVeGVsgMQtfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMZCH+2H; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2833009f8f.2
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 22:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771310331; x=1771915131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U3qI14HKpNjhOOGCbB6P1J+kAiQmIZ09Ug/I+e/MOHE=;
        b=eMZCH+2Ha/vVWqt0Xs7gqjmQF8dHIHZ+jmKM+SGqb9AViU/9Sz9OPHOkU62M/HnA8q
         bqj17s06lIg5qwyaTvLk/XGRXVgz6b9u2XRlQ+EYbqkD0hu9wGMfwseOSBiKsZ2VtLbk
         L1lHhBOe8HW8Ep6nFxXrxv6+aHYeqMmahr07v7rJ6UAy6AsPf60SaPE5ytm0g0WK2ll9
         hdv/OW8JxSKZE0W6Ar/pDJdA1Du/1OD4vs5Nl30E8iDOJC9Vn1KV/ezsSt72nH/3QJHZ
         ON7ANhp4uCgsupJthV0A8JHH8O6bRwwwloXjyg4Cx0tmzJHu9kiTS2vlkBZDWsDK/272
         2Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771310331; x=1771915131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3qI14HKpNjhOOGCbB6P1J+kAiQmIZ09Ug/I+e/MOHE=;
        b=tkKChvmfpApVtvpRFsbQdEZhUg7S9C18zkdFr02G33UQdk5y6InuWveLi5bvF0tyZZ
         XznZplqQ1vp0+R3jHCfs29yzJXpLh3uanyjOZY0Fsqqh4p3CbL+MiTS23L5AINDJB8zL
         jyLTK48IA7lZ+DZ+dTr/NWy0InOfnVA81IstTCTZpOLWhNcJay0+cPYDyojIgZcrrH9w
         syojcm/791b1YNfIlIYB7omxNP2o5bfquAMOCvsi1NMkRTd7diGtgXgdRZbYPuHyKMnA
         IfKVZW9elPtVmq7agHIxpTq4D8pYTTH3rDhLfHtHiGea86pzaf87IyiZ6h9sIcGp56Jp
         vB6g==
X-Gm-Message-State: AOJu0YzqUTG2lJvcwUHwZcs7oqA7aSbIvxdspGNWqaWO6mcBHIMxiFlp
	WD1Mkiu452pu9ANlBsV/s0quWAJAsadAMaA2Fn+HX7EsHgJjM4Rjj600
X-Gm-Gg: AZuq6aL6K7UELIUhSOeaX/j9ipve+MUn20EwfOfzBqKdjJHg7OgRCQICBt6E2AGEHKo
	CTtTqd3FY3H3YlBgLktMlvAcRCwwHcpHeaiQs3gzCCXNve4r0GgVpdt4EAPVU64ZJGZRX2Gv5xK
	Rh8PkATVqI9byfKivisEQT/wXOCBYyp162/LZJ6+maKgzPnYi+tR+PxZrlshTV40IeYUH1gHW/m
	2IvWgrvqWdlH2+4WBTqk9DMk3VL56W2mv8lYVoKwILPjCmaojOHrgk0J8iEJ2rnp3OehpZ3MgP1
	3wB99WkxoQLRmZjixAc2+Z2aVxJQZhKYggjgWUh4cmaNQ0NKi8s7UPl5w2JFYRRheAJTOr9Dzhd
	ez5NahadxSlClxGcT5jWUsHKJ3YJIf7+bwmeZqWv7X9wLEumMFOX5aGj3MXffQb51SC1/NIf4mw
	kr/UJntJhKdCnQy9T9T1WUwAr2LSSQBeP38QmzR/YCRarqfjn8DlISauwJ
X-Received: by 2002:a05:6000:402b:b0:436:1951:21f2 with SMTP id ffacd0b85a97d-43796ab181fmr25947788f8f.12.1771310330886;
        Mon, 16 Feb 2026 22:38:50 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1b4sm30256271f8f.14.2026.02.16.22.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 22:38:49 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E47CBBE2DE0; Tue, 17 Feb 2026 07:38:48 +0100 (CET)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH ethtool] man: ethtool; Fix small typos in manpage
Date: Tue, 17 Feb 2026 07:38:39 +0100
Message-ID: <20260217063839.2815434-1-carnil@debian.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258970-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,8.in:url]
X-Rspamd-Queue-Id: 76DAA14902D
X-Rspamd-Action: no action

Fix the ocurences of 'allows to' with 'allows one to'. Adjust as well
one occurence of 'withing' to 'within'.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 ethtool.8.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index a18e40ccdf43..e10a252f70b5 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1901,13 +1901,13 @@ support. It corresponds to IEEE 802.3-2022 30.9.1.1.5
 .TP
 .B c33-pse-extended-state
 This attribute indicates the Extended state of the c33 PSE. The extended
-state correlated with the c33 PSE Extended Substate allows to have more
+state correlated with the c33 PSE Extended Substate allows one to have more
 detail on the c33 PSE current error state.
 It corresponds to IEEE 802.3-2022 33.2.4.4 Variables.
 .TP
 .B c33-pse-extended-substate
 This attribute indicates the Extended substate of the c33 PSE. Correlated
-with the c33 PSE Extended state value, it allows to have more detail on the
+with the c33 PSE Extended state value, it allows one to have more detail on the
 c33 PSE current error state.
 .TP
 .B c33-pse-power-class
@@ -2075,7 +2075,7 @@ If the PHY's upstream_type is
 , this field indicates the phy_index of the upstream phy.
 .TP
 .B upstream_sfp_name
-If the PHY is withing an SFP/SFF module, this field contains the name of the
+If the PHY is within an SFP/SFF module, this field contains the name of the
 upstream SFP bus.
 
 .SH BUGS
-- 
2.51.0


