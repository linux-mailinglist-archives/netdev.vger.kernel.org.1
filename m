Return-Path: <netdev+bounces-103707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9DA9092B4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 21:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF537B26CF2
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F61A01C5;
	Fri, 14 Jun 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gtBlaZo/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCF19FA93
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391886; cv=none; b=Lc6EA1ThOwPzN0Nicvsa8SoW5vfXkfxnpIqv37nx/tno8eX31cS/k86rxPK2deJKVrhElQRa/N3o2wqxF+rwHPQvi7TD9zHEwVfXnlh8VmgAInKWcm4r+Dpc6NuuSWWYAgVmKKVsQIGuyUrhZu3LPVQca81sJEnio0RrYbwBbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391886; c=relaxed/simple;
	bh=Hdh96DNeu5O15TNIGmeJKcxmDvDRfqChBPKTWie1jp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk23rHpukoIbQX56RXrXB35GvUbp1u+LvFM9wtOKO+HISbLpVA7htyrM6B50i28XE5cT8xzSBl3Xl7BLKXaxC0kYLAoA6dFJ7eyfwjDX3jO/371PgTCi9vgpGMpYzjmZYV1NtBWaivkXHaGX5lC5F5MbhpMXepPiZTSU5tKucgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gtBlaZo/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b06446f667so12931096d6.2
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718391884; x=1718996684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hdh96DNeu5O15TNIGmeJKcxmDvDRfqChBPKTWie1jp8=;
        b=gtBlaZo/McfwqwaBJ3GoO1Wxr6XQFaidWs8T0S6gYiM2s83+Co8D7ssquwHobCGm+T
         xbd6g51YfMC1mpNEhgx9SD4e3CeaYsxORtiKQxdzcqMRpBzrf4b5LsVlnAlLbN8fwzSD
         sMl9NbCSWuHOUmonFORM8WUmXls/mwmFHufulwrBH73scBl4hXGnz/JVLkVP31tuNPC5
         73FNPhJoqRnQZov4WYthSeFSV0ljBiYs/P5tzQ2yVvWy86NQC2DBeqDWIME+ZsNaFL5g
         Z6PR9iEpnmBu/yyhZPTdOYL468WerIDhCFtJTi9sT6TxmxBZvUdV6/rOzQu8OQazO6C1
         u7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391884; x=1718996684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hdh96DNeu5O15TNIGmeJKcxmDvDRfqChBPKTWie1jp8=;
        b=ASQRjDyBKIvPex+KpdMvz2eIyOYpb0XvCbRmZd6ataZiUiYu+oUXOm0DXY6YW7QuzH
         HnqHPwcwtBNKcLmRs1nGRk4hyig8/dHSwOHE18NcbSW2L1sNhPSn2a+Zj91N7CaOZja7
         0vWur2mZsRmKj4FlKF1d3HEtXAldvLxeTXaRg6n9ZYwXZ1pNKRDB1EX2tXpy0PD9FaKi
         cflvbs0vq/X2RqsMtnxcfWUXZcyU3zGTta2EY9bb2/3gP+IKOMHqcL54V+ACgzNqH7uu
         81wd50Tr/1lNhQ0YF4B2pTacmYIX7ywXwLF6J41y4warLGgWa4jWyl0+E5aIWrSugNKD
         rmUQ==
X-Gm-Message-State: AOJu0Yz0dRbJAi+o0V2ICyoFOQervxiFfU/xKuW4cq5fhZ5qesWqMS74
	rCTbNe3dXhVxxWTJkzq6qKuptvsHetSaHxDNs7BVsZWJlLkiFBaqLyXP+E4E7TjvyyAvWPMbTBe
	Kl9xP3wF5mfvnmdAnEjbCY9M6YMxeFLT6do3y
X-Google-Smtp-Source: AGHT+IEqk0+RaqSbOzvS5VSZBxkWGiiPBazEGl9HoA320TDzUGaZQHRGxkEQyi/8W7l5comlriZIErEBAFhUZ1pxXBU=
X-Received: by 2002:ad4:56e7:0:b0:6b2:9d43:f060 with SMTP id
 6a1803df08f44-6b2afccf0c7mr39897636d6.33.1718391883377; Fri, 14 Jun 2024
 12:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613071021.471432-1-druth@chromium.org> <CAM0EoMkrTcMrsd=8249inrU4HaCP9nh4xva+LO1ayF_ONH=-DQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkrTcMrsd=8249inrU4HaCP9nh4xva+LO1ayF_ONH=-DQ@mail.gmail.com>
From: David Ruth <druth@google.com>
Date: Fri, 14 Jun 2024 15:04:05 -0400
Message-ID: <CAKHmtrQnUZQddue2HGq8wAvE_N_esYv2DwMNYp5rOArGzc2kZw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net/sched: cls_api: fix possible infinite loop in tcf_idr_check_alloc()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	marcelo.leitner@gmail.com, vladbu@nvidia.com, 
	syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Small nit, should subject be:
> net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

Yes, thanks for catching this. Resent with the suggested change.

> cheers,
> jamal

