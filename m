Return-Path: <netdev+bounces-196543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C09DAD53A5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2341882D26
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5D2E610D;
	Wed, 11 Jun 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UicAyvto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6C2E612E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640525; cv=none; b=GbRAHSpS7MRPmCLsH8e/koR+R7lRRKtlNMzUN871fB3xtEARLJ0uOS4COpTHvwAhK6zxBwHsgSbe5sLfVehZIHfht4WsDywz4Z2Ofje2PP5cPGqFdc44M9+ZMQljZgFP3rI82eRXJvYOi0aIaVC7ZsP84WLJjXVBSnrKfOaYT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640525; c=relaxed/simple;
	bh=e22TZfjAj25FYcggcmy/vNi5f7AWdHCG8yVglhysrBg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ArWMIgRuWcEHqIQtQFkddgXwZb8pGCCm/HGQBGhSSNnKhpqFXH2JFvNdizOtWNnOG+Jl33DVlDZMTdc93Tu33jcOCQjNzSoONbw1EPwiQMy8N9exSOVsBPanrehzEy69hx1OFbfvvzhdTBoTHKl2GWDQ+ZOuq9/5AH1FQ8Z6fJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UicAyvto; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fabb9286f9so122249416d6.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749640523; x=1750245323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0PF77bviCTahCF/tDFWzbyKmwQ6Dj64CJMwEEqk7xMc=;
        b=UicAyvtop0jzOf82KLKEZmLbr87zl3Zl+N0ybt9ZA8Bvf0BvY4bvWeoJKq1IcvtY0E
         c3JjmczR8FCvFXpz9hVVBMqnqVBvIzaSqcMV7xEWeIJK1Kc++BgJCgdKvkdy2Jog2SxK
         MdCUD0aTnochq3G8X1Us3qjTiIBbFC0WKIDyVPaJMaZBqviTbRXf1CDebJbSH9ykpZPT
         7P6CrUrOuLT7ZkpmUR48cSx+nqoPQm1DZ8KWrUpWoQB1YSds5+9I4UV3z9Qtq4pJgGaq
         9mYkiIbLDq3WLX8yDNHTaf91QRZ/BMQmy1RQYIKdhnDcNGM4EDtfiBqsUvXKACuYZNrK
         m94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640523; x=1750245323;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0PF77bviCTahCF/tDFWzbyKmwQ6Dj64CJMwEEqk7xMc=;
        b=pqhi9YyOdRdbzowtVa+trqyO1vL7U/ARF1NG/Ek50Dz6nxu/sYqxw3ZQY9/NhklCd+
         9oFAP3bnoOaS35r0dj23bmp0cYvtOs5MncOOX5IOEVuLVNuqxgwEzFZIFxWlD2ujJbBy
         ASqSrljSnIc1wCa7kWtUuOiULYnMFyrN1sAcQoIEh8yQkSTP1H9LD1nbtw+yqDw0zIjC
         bp19la58hV8W+ym1lw+gALN3zP/jgh0FVilroSQ8bJ+ahskkqcjKGh4M4OlFYkHcvQb3
         Tb/9OXOi6VRRoXxkrebLSsr36jZzKINbs5HNx/fY/hgIMdS5bw6GVa3bQLWl1VZzTZf9
         gnAw==
X-Forwarded-Encrypted: i=1; AJvYcCUWf13bfcNoZnAo0RLhtQJmAYWrxQHnL7zHBSjAzhj8ecW4ivgEKiop386oyFIWQyai8uKmDpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1DIuqrXeYYWFWoOO/kS52ZydakMJhAKjgQmp+PQZvOMab/RIW
	YnoivRYmaDNO2E8NSWaK4V6Lz897q5NQ9dj7w7lTJ3I5OLmNQiHZsW9hQx+KcKGihSvzFalaYCS
	C5MGeGX+57LLyHA==
X-Google-Smtp-Source: AGHT+IFb+/jIElnt9vf5/3jyCH1b/qcOfuo+flEUU+Qit3GVTQfPN8K9K55dXbMkhgl6ztJ/cU69y79E0sk44g==
X-Received: from qvblb24.prod.google.com ([2002:a05:6214:3198:b0:6fa:9363:66af])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:29e5:b0:6f2:d45c:4a35 with SMTP id 6a1803df08f44-6fb2c3727afmr47007366d6.37.1749640522992;
 Wed, 11 Jun 2025 04:15:22 -0700 (PDT)
Date: Wed, 11 Jun 2025 11:15:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611111515.1983366-1-edumazet@google.com>
Subject: [PATCH net 0/5] net_sched: no longer use qdisc_tree_flush_backlog()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is based on a report from Gerrard Tai.

Essentially, all users of qdisc_tree_flush_backlog() are racy.

We must instead use qdisc_purge_queue().

Eric Dumazet (5):
  net_sched: prio: fix a race in prio_tune()
  net_sched: red: fix a race in __red_change()
  net_sched: tbf: fix a race in tbf_change()
  net_sched: ets: fix a race in ets_qdisc_change()
  net_sched: remove qdisc_tree_flush_backlog()

 include/net/sch_generic.h | 8 --------
 net/sched/sch_ets.c       | 2 +-
 net/sched/sch_prio.c      | 2 +-
 net/sched/sch_red.c       | 2 +-
 net/sched/sch_tbf.c       | 2 +-
 5 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.50.0.rc0.642.g800a2b2222-goog


