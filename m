Return-Path: <netdev+bounces-120901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284995B295
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48581C22DB3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623E17F389;
	Thu, 22 Aug 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ex7XHPTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388161CF8B
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321111; cv=none; b=QEBb1ZQ86nlVzgIzGfIosZg1HahV86PkMPuN5+ahshdEfxEa+NtQFw95BS0Xhn3ZV55KtHZDfTEetcFEsPNQl96+eYVMI3hEikZgD4dIB55IWY2UxN9n/5J5uPP70eqGgkrbk+dL8iVIIbPr+9b2JAmEznfFbrW/72VPKqzf8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321111; c=relaxed/simple;
	bh=LGDqWDhluVyRi3QnUcdGPQZqAhMpk5/LyhXofJ9pww0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTFNDdkLxrqYVysOSB8HuMiJTJVkqGiDbs5GoR1PMx3thectZnCREHUv196M77GVpiiToW4PLcScpwthzEQReP7hyRbYXqOsn9kg5t6gB4npyBrbLu5dM010uB8t4+Zm4pMWXc+VUhOEOwa36P3jupQx6EC2A4Va9r60SaocX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ex7XHPTA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fea44f725so4529051cf.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724321109; x=1724925909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OF6fNQ/TVAUdaCMFdQ7KgUT0eASl1h9Bh2nwbXzaCMw=;
        b=Ex7XHPTAD8Jsi7fHKZiGcpUjaHhxLX9IPlL2Jk5s/yiGqYTqRUdKdxTRoqBxOJ7Q/b
         +erfYVZi2v/LabVVUpvhMN+riGKaI3+VDcImspw9X9aGE8rugBrs01pGvQpG+8cao1pe
         FZRp6Yn3XqzsLrvx4kiXhfuhpeo/DT2ZGzraA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724321109; x=1724925909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF6fNQ/TVAUdaCMFdQ7KgUT0eASl1h9Bh2nwbXzaCMw=;
        b=Uowd39RC5oHURjJqaKzs8A+tLDFhtdohfjFaX3HhuJ397mYAjFcoQz1abUpvh+I36O
         sI9zQ6raEuahTSKMhnrk68IpJ8e7QNThQ3mNM8M0T2ZmqU4RBMu1luQXp59XPeA33MTQ
         4fFTjIm+hrrn88xmYdQhVB82BQw2adiEia6Wwm6xiTWuon/ZlYoIOnOECoe/T9zBk2NX
         dlgKpTCPSewtUAjAAXlMsY+DCODxCOQ32hW4oAaj4JsWOEhQdylDIIreKA4hYvAaXW/d
         8nD/6SO8uvwfDFDa+TenEjIDGZKz/HFrvQukdaRoH1eQeH/d3UxjelD7FKI6hXZ5xeL8
         yilQ==
X-Gm-Message-State: AOJu0Yzvyp3LBjRXGKzfXbqMcb0Oa/iinbN+haLymT8rnMt4hHNwNZak
	DPix7MDrjz1agBa7j6qCmhj7ii4Tf8aKmeWDuCNywsd0+BApTLEdEY2cLsGCXg==
X-Google-Smtp-Source: AGHT+IHZ8DDaVpEN66dUyTD35xaIyc9eneZpe54btUki9zoKTJVWD7wkE7ffmsa6qeO691bTz31k2w==
X-Received: by 2002:ac8:5996:0:b0:453:74d5:55e4 with SMTP id d75a77b69052e-454faf049bemr45925131cf.26.1724321108935;
        Thu, 22 Aug 2024 03:05:08 -0700 (PDT)
Received: from ramen ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfbf973sm5147161cf.2.2024.08.22.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:05:08 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:04:53 +0300
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Howells <dhowells@redhat.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Ido Schimmel <idosch@idosch.org>,
	Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH net-next v3 1/3] tc: adjust network header after 2nd vlan
 push
Message-ID: <ZscNRU9a8DWBQ67K@ramen>
References: <20240819110609.101250-1-boris.sukholitko@broadcom.com>
 <20240819110609.101250-2-boris.sukholitko@broadcom.com>
 <f6befca6-4f89-4d9c-b3eb-68e80da5c285@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6befca6-4f89-4d9c-b3eb-68e80da5c285@redhat.com>

On Thu, Aug 22, 2024 at 11:41:19AM +0200, Paolo Abeni wrote:
> On 8/19/24 13:06, Boris Sukholitko wrote:
> > diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> > index 22f4b1e8ade9..9e2dbde3cc29 100644
> > --- a/net/sched/act_vlan.c
> > +++ b/net/sched/act_vlan.c
> > @@ -96,6 +96,7 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
> >   	if (skb_at_tc_ingress(skb))
> >   		skb_pull_rcsum(skb, skb->mac_len);
> > +	skb_reset_mac_header(skb);
> 
> This should be:
> 	 skb_reset_mac_len(skb);
> right?

Right. Good catch, sorry. I'll send v4 with the fix shortly.

> 
> I'm baffled by the fact that the self-tests looks still happy?!?
> 

My guess is that the TC code path doesn't look at the faulty skb->mac_len.
At least the dissector doesn't.

Thanks,
Boris.

> Thanks,
> 
> Paolo
> 

