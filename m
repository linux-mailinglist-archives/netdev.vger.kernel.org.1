Return-Path: <netdev+bounces-111641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFBC931E97
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1881728315E
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40D1B641;
	Tue, 16 Jul 2024 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHlfKT1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF18322B
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094850; cv=none; b=ZW9wJYN5u9tmeYte9RR9OSxT0XRgIjXeqjoL4rrIEJbyOXfcIgljt2ZVFTTJecK9bp7lUhKmRKD6PG2TuQwMTjwyu/S3DWoMoE0V/4UvI7qJaPDfRNnyMoB3I1UJ4KW0jZdtI0U3ORUkSfiCNOKnXF82y8xGtgRXBeRFFnynHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094850; c=relaxed/simple;
	bh=6/8Tp/q3vT45Y08hNwJQOBWaoevnWiEbiu+oGmlJpFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r1HcrXBJmMmt03jX/ljA3JQPtk+5WLgjNOVlyh4bJKF3oCvJ2SoaFOZTSEq6c4pgN79NLAq4sM65K6GRAhYqwHdH1KM2ucq+9wXi8q7JgGYPjkxK7b2vu/4+2804oeezVEMjx+EcQLiMgO0nSoAOK9oZx8sPPz7WMzFMbVzG+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHlfKT1g; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03654427f6so8963222276.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721094848; x=1721699648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5RZkAsr7KLWKX7p2EN8cO7UxkRsrsLG3kKSZAIPNIg=;
        b=aHlfKT1g5CG8z2ZEAX7W5I1fTk4GvgBSqKUWSVcX/PQcHePwn4D/ksrZMLH/DJ2KA+
         ra4Nca1JfCdqRIPZEh4Y2kT9wud2MaapcMWb33zd08L+VvzWVCcmYVVrdZfmWhwlPyF7
         j3tze20nYDf/Fss7OPFfNN8A6KSWXdyDwpgyBINupK1bba1fL2955t4Lj15zSIMISa2O
         XhWJEzRe6EsfZFvc/jwTg70Kb5wWzbrx32FSdYYRJfDEhHA+BD5AWneCI6C+n2Q9M5wd
         TOkgALOjPPhQd0HO3bmoNMyuelwcd1X1Pf1I2k+LbjzaT8c+8YNILWWdODRDgfRKPR3V
         wO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721094848; x=1721699648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5RZkAsr7KLWKX7p2EN8cO7UxkRsrsLG3kKSZAIPNIg=;
        b=jb4sYxXZ/C/WxUhiJdIxET4C4oKFUAo7pDHCVpJD2RDeT3u+kpGKRtL3gOhZbUUCIl
         tVlZNr0xRIUgiZd8/SWa0dWAZ+cw5IFWF9DYnvA8NO/LHZBhB/hl+3WwdWm5OqLyNugB
         /GyhvGY3FPT05cboHrpqgVUF/SSxt1qXdrIv0snhUvpsOFLK22QXyCzpGzyhEisHUjDz
         xvwIRz+WnfLXDVucrKjTrCiDWbR04q0HJwH7Os+/99e/miXaB8fTuLnRxpu0QHNbzOeL
         jIXiFNVGrQSl/F/7S1PwYsvTT4nfK5p69LF6LZrT8NLTo1nH/ypSVN2VBBXTWzP2lV25
         b56w==
X-Forwarded-Encrypted: i=1; AJvYcCUETRkxRw8L8bW/VFuXmc4dEOQzrQ4Tb0laKtnEgL/qkRxOni/wR1P1sv1I6uNUCJ4VLKtPxVv3/eZF/gPkw/le1G4y5WYh
X-Gm-Message-State: AOJu0YyTJwG1RcVZZUHpCvGIpyolqQ8Qr1gpSdLPQlHywQvvUCNyoDpK
	v6B8cK5ES1zIURsNw2WZ43NehNbw9/haZZI0UBY30P+j1lHWjJ8A+xJtCyErT7IWZiGQvzV0KbD
	yKMC6KtvhYQ==
X-Google-Smtp-Source: AGHT+IH61RbCRJgYP/aRn6piDxePFbusYpNCV11qo30Rcg0Y59wb1vm+uC72BDLO8ZI7QUNH+QvVToaGjVZ79A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:230b:b0:e05:a1b5:adc0 with SMTP
 id 3f1490d57ef6-e05d57babd5mr38419276.10.1721094848231; Mon, 15 Jul 2024
 18:54:08 -0700 (PDT)
Date: Tue, 16 Jul 2024 01:53:59 +0000
In-Reply-To: <20240716015401.2365503-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240716015401.2365503-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716015401.2365503-4-edumazet@google.com>
Subject: [PATCH stable-5.4 3/4] tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
From: Eric Dumazet <edumazet@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Jon Maxwell <jmaxwell37@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

commit 36534d3c54537bf098224a32dc31397793d4594d upstream.

Due to timer wheel implementation, a timer will usually fire
after its schedule.

For instance, for HZ=1000, a timeout between 512ms and 4s
has a granularity of 64ms.
For this range of values, the extra delay could be up to 63ms.

For TCP, this means that tp->rcv_tstamp may be after
inet_csk(sk)->icsk_timeout whenever the timer interrupt
finally triggers, if one packet came during the extra delay.

We need to make sure tcp_rtx_probe0_timed_out() handles this case.

Fixes: e89688e3e978 ("net: tcp: fix unexcepted socket die when snd_wnd is 0")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Menglong Dong <imagedong@tencent.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://lore.kernel.org/r/20240607125652.1472540-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 76bd619a89848a2a673b49fdb034037b454ced18..cbd4fde47c1f8d29533bf5ce28bddf4c9a00efe7 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -439,8 +439,13 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	const int timeout = TCP_RTO_MAX * 2;
-	u32 rcv_delta, rtx_delta;
+	u32 rtx_delta;
+	s32 rcv_delta;
 
+	/* Note: timer interrupt might have been delayed by at least one jiffy,
+	 * and tp->rcv_tstamp might very well have been written recently.
+	 * rcv_delta can thus be negative.
+	 */
 	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
-- 
2.45.2.993.g49e7a77208-goog


