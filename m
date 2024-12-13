Return-Path: <netdev+bounces-151922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFBC9F1A0E
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C725188DE72
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744C1F4293;
	Fri, 13 Dec 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fGwY7Nxb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166C1F4714
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132616; cv=none; b=fASW92f6hOUhfqxZFocWs0z9gxpFKb3UN+iR1/fys1/YyZ0X1P5Km+ku+w68uAP0lN2ARRpFsjY31AsK5RYIM/WV1YokGPHAU6PaTTLcJXkYeRP8jNzCdLXV7lkpir/cqgasQz+3sM9YX893ltU9ZTXUTvgEqHUgh39g2UXmtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132616; c=relaxed/simple;
	bh=/0LCHSqF8KD3uMi26Ke2tYmcboVwQRw3xrgQ0ODt+Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnSGidh4iCL8dmvM0WaC+aOlKCG4dYO8GRpLgHHuLWWU6u64KvkQYEi/ahEKJkybZg+4Q7BecEMF8xjPAOHsAuxnncb62nd8tNEqOZTTO87tegWi2m8pcD+r4xa7sipei79fAtPReRUrFwFemZaIK5IN/EILESS+2hjALiM0LEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fGwY7Nxb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6f1b54dc3so312450385a.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132612; x=1734737412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4MtU8Of42Vm+hc01puGWyYYlZFozHrm711A1SI/d2A=;
        b=fGwY7NxbOXEnbx4jxWu9lZYXo1+i/MMi/UGU6GB7OxiiTNY/UosKQfKXAPZsLCnVEZ
         iIy5w9m/C9OkJg8wB83SzZNUVgqtw846+rTpkC+KdOeY3ZGkeTX+JmaZgLQhOzeFpW8T
         jtnbCok440CxGAMbIAHX+JyDfn5d1/nYwaTouJi3L8Rx2sQaGw6cqKC67PjCurzNTqw8
         Rkb/Wui5J3aE8d/RrehjOxj8YEOZyFiwhxvpg/4fNpDUPpSNIK2nIpjGTxwh2K6NqU45
         8NNK5w4q0H8VTYAE2z5RxreVYseObPgqThnKGMohiVJtOudtUvWU2pjydBfmPt6ZHvKw
         EIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132612; x=1734737412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4MtU8Of42Vm+hc01puGWyYYlZFozHrm711A1SI/d2A=;
        b=M8OCUpzgicsiaHdXYn0B4DnfXKxQwNh3Ero0ug3+UrvHFtBENehENIGhaFud1vn/dY
         KPZfLq7p5A2vH6sMBIL94S0FTw8L78iEffzy5QgIJaI9j0lvH3CDptsEn0+iIbMLqoiq
         LNsgKqO1UYUwQMBJrUxpn+sqaBhxYJ9+LNdRiim1mmSC4T5vO2Cy5pa+SzN8AeODGCuN
         JlziuOk+4hKa35EVYgmPvuf1aUvGEQ6TzPTkFDH68jkhIZcVePp8FvfrzDVNLPNOU+AK
         b1TxRCaOAVm90G/foYDBZgAiyHuPdsTmg443Irt0CWQWPmUsTc2JosNbOcTXedQm+Aw9
         Fz/A==
X-Gm-Message-State: AOJu0YydwKkwWJpG+l7VXfqAeN5ZzDrpGOdEGcx3/Gt3GipHmE4oOz8p
	XZcyxZW0eM9imqYcG8hMjYDCnR4oqoh2MBk86M+ck7zzjLVOSN41FC2/hOHoLdYSJzqrkcVwkKX
	XBxk=
X-Gm-Gg: ASbGncsfHGrZ6AR1ymlz1SqZx4fy2ngthRmndyeZtFWaEEJ0TUk2PI7W/3aQxkyWOfb
	1yiIhc5r9qCh6/1G2rrGP+i+wyNsLq1DCaalK86nr/9MZO6zGXsSld7dINGiloN8yWtKgftT9ig
	u5bCc4VDMEgvRd93ey3QkFb9TgOrA+eDsxKGaT79iDR0uP1bbmbqOKPui4UXnt2UAp1iVO9YZSB
	U9UaEgf5SDxv62leplxm0o8k+tatxBAbLgEajTmdveUfm0NHPLcbbS8cidae0BgyIVOhcHdKhe6
X-Google-Smtp-Source: AGHT+IGhk3WCBCy2FnCcgGdTSmylboXkEW41jLfVsnBq+KCm46Gw7HQPdPsfaiQEvFTTaC21Z5+zCA==
X-Received: by 2002:a05:620a:45aa:b0:7b6:ecaa:9633 with SMTP id af79cd13be357-7b6fbecc538mr761652485a.7.1734132612728;
        Fri, 13 Dec 2024 15:30:12 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:11 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 10/13] bpf: net_sched: Allow writing to more Qdisc members
Date: Fri, 13 Dec 2024 23:29:55 +0000
Message-Id: <20241213232958.2388301-11-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow bpf qdisc to write to Qdisc->limit and Qdisc->q.qlen.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 3901f855effc..1caa9f696d2d 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -89,6 +89,12 @@ static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	switch (off) {
+	case offsetof(struct Qdisc, limit):
+		end = offsetofend(struct Qdisc, limit);
+		break;
+	case offsetof(struct Qdisc, q) + offsetof(struct qdisc_skb_head, qlen):
+		end = offsetof(struct Qdisc, q) + offsetofend(struct qdisc_skb_head, qlen);
+		break;
 	case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc, qstats) - 1:
 		end = offsetofend(struct Qdisc, qstats);
 		break;
-- 
2.20.1


