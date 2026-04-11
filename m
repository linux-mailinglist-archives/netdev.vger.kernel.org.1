Return-Path: <netdev+bounces-277659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOBWI17Z2WkItwgAu9opvQ
	(envelope-from <netdev+bounces-277659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:17:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A653DE638
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB907302F431
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242727FB3A;
	Sat, 11 Apr 2026 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="o67kgZTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759102609DC
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884635; cv=none; b=rRmVReqSUw4PRiViPwmi3d5WiUUjo7Ms26BxZmXjUFBMQqSL2+/VJxNfohD5IPikx4ojfwJDVmoQxiaNdSQHpRXvZWBungnSDl6MW2ZaTnJ7gz5Cn7n/sQ1JofYF4VL64tPRxktFft2wto7MWTT+TlMbvJJZTH6CagWy2WSFosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884635; c=relaxed/simple;
	bh=fbqM3x3GD1CCUD2vyX99XNBmMghubH80srElmDJt3Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc1lByiCAuS0WrgAKACanBKn4F84kZrgcoX2ryWjxvpM8DdgTgukZseuFQKIolfcAPuBLUF1wcQxR+qw34Pri6hmi97e5oQtui3QYv5JhuTQPATTeujfodSGzzkIs4hmOHFnsZBWURb/EIVXFP2sB7MCDYXJLo6TOK4Z98fokpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=o67kgZTL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so1814577a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884634; x=1776489434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=o67kgZTL+CUNCLacQwaYTaiezaet4Ceeto1+KOSmsgNjbR0oWnfGm3FwG+OpZx4zJ7
         gOvLvVMSRE08ydsu3uZt18nf62jOU+90ff0lnHg4/feSlO0I4pLbD4RYxpxRFOigVdoB
         fanVWv3rgcopgv9xtylvmEslaGh9A/NM6iCIW4XLb2WITSBcl1JtZaO0EB0MuK9mo0iD
         QHzpxxLTgEA/5S8TEppCXL9s85U1xgfPo6VF/wd8NAL3zHnmGiJ00zlVpFulmJxsdRBE
         d8AGkRICN1cJt3MCG4v2w7aC1lvMQOCOBK6disQzET9XiVx6YFYTEEDycUGDKaEjqDnu
         0ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884634; x=1776489434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=Y3UAP3Rd1rGNaeN+pSbL/z18ambDPjT8D/ns/6Pi8ULjMtgMhgXf0eRRRMs7v/SrWV
         K4wcYnsKSuYZMUhkOXbDoaIUNCtiMda8wb2R7RGt+jiTyz6ywBLuvixPWbnlJpaFuXX7
         mpoV9IEbRk2rhji6C+VurHAcpK+tKqV0Lz9xm21BFAAhzIiCyxig5L3dIqj3ER6LloVO
         2IAXZCUSTSV4VBj93geOYHFF37Td2MVKaoufZ2AhcUwN794i3kbzTx6/1uqcvGELFkC+
         VGZSIPnfgy0LBJ+UllQKMkk3mpHJDj8ZSB5FflbS8xPqdOHCUkCPfKjLEw1jazOijETS
         6NYQ==
X-Gm-Message-State: AOJu0Yy3fkCYW2eJ39fyB7uEULb2682MXGep12TiIu1lo4Qw6xd4tZp4
	aYnEhAILA/gOmv1udMKDV27JXlKxc99w7YwdCvk/N6CXh8W1M//dcCMuPbduzjZT4x4rFuDgRfx
	uqt4k
X-Gm-Gg: AeBDietoyF6ctJd+e5GLY5KpUV76qbn65IebcDm1FlRKM9NOg4YK8KTOyjuLvPc5KPU
	pujDJy2lI44OKORjw7HD4iT57QmQsCsrs7zyb4bNcyRHQuOZnyDzzxBs7+CwfsEgMAi4cC2Q3yt
	TD/Sdu0hpZuMcCQacKRS5HTWzah4BG2JyvAph6URLYDuRdrRjZ/iIL26bI0Fl3yByhZaK6NNbMD
	mFRD8xpb5hsZOn+lPFyN9iYuvfOUGDqi7gHdztYfy3IhgUYS5ZTi5RMgjwWp6cPLccakMQ6Iafm
	3pe6AVk4vLo+2cDrA/cYpdG7cnkNFhimol+lYvwjvIQitxBKLkb4j3ekBCPiR2YCOwWTOQ+lDcM
	fWBLHjKpn1QgFHRIwP9BG8dPsUJzIW6aUmoIpWE/wRYQ4eStyZBZtWOCftvMrYxX/aflZ+ElSau
	rNXPRglVex5u/klISAANQ5sTVrXmVCJBFb
X-Received: by 2002:a05:6a20:9389:b0:398:d6a9:fc9 with SMTP id adf61e73a8af0-39fe3c78c5dmr6605779637.5.1775884633973;
        Fri, 10 Apr 2026 22:17:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v5 1/8] net/sched: netem: fix probability gaps in 4-state loss model
Date: Fri, 10 Apr 2026 22:15:50 -0700
Message-ID: <20260411051700.311679-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411051700.311679-1-stephen@networkplumber.org>
References: <20260411051700.311679-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277659-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05A653DE638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 4-state Markov chain in loss_4state() has gaps at the boundaries
between transition probability ranges. The comparisons use:

  if (rnd < a4)
  else if (a4 < rnd && rnd < a1 + a4)

When rnd equals a boundary value exactly, neither branch matches and
no state transition occurs. The redundant lower-bound check (a4 < rnd)
is already implied by being in the else branch.

Remove the unnecessary lower-bound comparisons so the ranges are
contiguous and every random value produces a transition, matching
the GI (General and Intuitive) loss model specification.

This bug goes back to original implementation of this model.

Fixes: 661b79725fea ("netem: revised correlated loss generator")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 20df1c08b1e9..8ee72cac1faf 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -227,10 +227,10 @@ static bool loss_4state(struct netem_sched_data *q)
 		if (rnd < clg->a4) {
 			clg->state = LOST_IN_GAP_PERIOD;
 			return true;
-		} else if (clg->a4 < rnd && rnd < clg->a1 + clg->a4) {
+		} else if (rnd < clg->a1 + clg->a4) {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
-		} else if (clg->a1 + clg->a4 < rnd) {
+		} else {
 			clg->state = TX_IN_GAP_PERIOD;
 		}
 
@@ -247,9 +247,9 @@ static bool loss_4state(struct netem_sched_data *q)
 	case LOST_IN_BURST_PERIOD:
 		if (rnd < clg->a3)
 			clg->state = TX_IN_BURST_PERIOD;
-		else if (clg->a3 < rnd && rnd < clg->a2 + clg->a3) {
+		else if (rnd < clg->a2 + clg->a3) {
 			clg->state = TX_IN_GAP_PERIOD;
-		} else if (clg->a2 + clg->a3 < rnd) {
+		} else {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
 		}
-- 
2.53.0


