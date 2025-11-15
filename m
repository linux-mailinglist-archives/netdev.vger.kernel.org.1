Return-Path: <netdev+bounces-238821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE1DC5FDD0
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D835E3BEB24
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730F20E030;
	Sat, 15 Nov 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GB3CCJW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1E2010EE
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172590; cv=none; b=Q7ziXEdLO6AaKfbPSO4lrYvskGYoGIUAMkcNNcneqJ3qvfUT5qe8xnaN2TkNk7EHhGJHxnZCUxlFE+W8m87i1P2IeHfUa56tXAH1T8CFSUhLjHbomn+eqSyWpNhq8oZ6v580sjtJLUIya4fZb0nd5OIHej02nNIG2L2F9Kso6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172590; c=relaxed/simple;
	bh=RhTs2UMAM7mGrbSJGsddE5HGwdz5f2Akfx3ZuWlSJm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncGHRxTkXOB4rml0jNom+oap+I8Semd5ToCIBNz3S3tqUshNoCXmPDHE8aLdhe94OzKkCVFy+BcN+/TB9V+xVo+SgyGBWsYR3naIgL+VxyzpMVIEHBhNPBxUEs85QLg4DW4Zm/STL27WcGGKL7k0i2bGXKymXKRr6quQqFKoncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GB3CCJW4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-342701608e2so3072285a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763172588; x=1763777388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0nEz2xxXI0f+uxwRCpO0ci392KAmJEojR85WaELeQM=;
        b=GB3CCJW4mVCXqfcs4lFAyOB7w3/qoKXyMcWm++KvUK/etSOEIqYzlsPiZyvHfeE+RP
         O4FFJm/gq+eZgGoAIDbIG8WvnPPqT5Yo5a+qLi9RGfN4IVrVCHo3vfmwZECsx+XlPDtW
         fSjcihq6URX22nV3/sJriBotb6liFAMJo2rmOEjK64ABtaDeq9OcUsb2qAtWVONqK9EI
         1em2loTA/+SUNyPdhnFwPtFTSWYUdaEuQeg0hD5a90tz6oahUqpwHoVtmoLLw1gKvYyg
         BCnpipVDLFPCXwS1cuI7zgySjmbS16yjblvsOeUJJEG6TsKHfjUbu+dacbgBXOrKGoaQ
         dvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172588; x=1763777388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0nEz2xxXI0f+uxwRCpO0ci392KAmJEojR85WaELeQM=;
        b=mKVKMHna3dy8YfN+lbWgjB1MYTgzap6RWxkyLlmwFEoi94uy+i6LLIhvVPLXUn7eh6
         3W7F/y18oQWXMiy+i3e4ZT6VdzmP/U7qtNtysJnaeDjf/GX/T5QY0sjvqcwkTlEt0RTJ
         Myqj8w5WwNaSI6/PRLeogVNlTb3gpTs87g7MMbfsHZwETmLhX10vsFdqqnSebjv8mcQp
         MqnJxqS60X1RxeFFXrAryhSOii5xD6ZqY+aniKLwuaqGb2qeqDcuOo0+8hmMdiQNuvr/
         CclU8Z8HhS2fclV4NlcsP/kSMOT+UwVNogLeMbslFwGNVBuiyge0iNEuFSVhsEGXUXi+
         73TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWavYzChHn3cF4TH/itX94sBPRcCqpntiP+xrJMEIAraQF0Px2SXFnh/WLKeOfJCtQRyIpiV6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYC6xRfBnSlp6sJFBxNHLgXqScpqy1+HDxPn/4zR9bwThAfNaz
	XhhrKXuXe2QseRmUaI5zxR2HJKI2gWvEM5CoLEtJau8plWkd6yYhbQp9fQdwPKcQZSCXSU11uXi
	VoTOPbg==
X-Google-Smtp-Source: AGHT+IER/MxG5KDoBis2Dju2E+Vkg8tLn5AzukPEYTDo05Oxei2d2orauskFQ4JrATiOlblF1zBfQLvcEx8=
X-Received: from pjpq7.prod.google.com ([2002:a17:90a:a007:b0:332:7fae:e138])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f88:b0:340:c060:4d44
 with SMTP id 98e67ed59e1d1-343f9eb4424mr5705847a91.14.1763172588285; Fri, 14
 Nov 2025 18:09:48 -0800 (PST)
Date: Sat, 15 Nov 2025 02:08:37 +0000
In-Reply-To: <20251115020935.2643121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251115020935.2643121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115020935.2643121-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 6/7] af_unix: Remove unix_tot_inflight.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unix_tot_inflight is no longer used.

Let's remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index a6929226d40d..fe1f74345b66 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -200,7 +200,6 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 }
 
 static DEFINE_SPINLOCK(unix_gc_lock);
-static unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
@@ -226,7 +225,6 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 	} while (i < fpl->count_unix);
 
 	receiver->scm_stat.nr_unix_fds += fpl->count_unix;
-	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
 out:
 	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
 
@@ -257,7 +255,6 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		receiver = fpl->edges[0].successor;
 		receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
 	}
-	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
 out:
 	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
 
-- 
2.52.0.rc1.455.g30608eb744-goog


