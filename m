Return-Path: <netdev+bounces-254237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLpONdz+eWm71QEAu9opvQ
	(envelope-from <netdev+bounces-254237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:19:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDABA11F1
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05E623009B02
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC52F0685;
	Wed, 28 Jan 2026 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1hVc+Mu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69962D7DF8
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602771; cv=none; b=neH0OFEmT0e2dVkW6DhexRz076pUO+rNitRCjyQDq+zFAJCyGTcAwo3VsG7hNUtrvUfi36aYJFGZrF1ioj3WwOotGy+qk/FT5JBDaX2CH2b8Muh09YUy98g9ehfndAdvbNGzEtslQbkxyJA2c5qJb1PSBUwfj8fOFQcrNp286tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602771; c=relaxed/simple;
	bh=JdR2rSf0erIkSsIXKJCpS46c4lCkQLcL84h8P8VBYHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHakyuK0ppGfmIRy2wlxJ1jO0wENjOnuosdCTAWGC8bYM5JDw80qie/ZUbIQvPtz3zLN3OOL8hdEPIYOXY4VsPSWJLjLqOgkaABUGxGsabOnUvj2r+1mmGRuYwJOPpElb4GiHiB2Gdru3K9JtId0XvtDbdxa3l781qqefXC33Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1hVc+Mu; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a1b4dd40so733855c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769602769; x=1770207569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRGkP5+YEwarPAqoRUSfhM+YSpi6qiSMYzget0HX3O0=;
        b=a1hVc+MuX6yWLLvsg32JUOuh4Hr8PuUDjcuP60C7Wn2idqYGIbXcGWd43VYgWD36UU
         9mfkeV4noAqZBflWpdwSeFzjn9elpi1MBFPfbpHjpCafknkNkkRZ9U/9qHukn2+iq2Tu
         7BOFbkT6L6X4pWj7feziyaqWQw81JNDEd8Kwq+gfSggbKkOFXAMHgR7d+EWqDs1Ga3q9
         m4UNFYGDsd3H3yVDsMzhshl5rSau+cnCFgdCrncJW5ZsTt0pcO/IvsPBpTVpj9yR1Pv8
         D8GK4fS+uYqOTrCk2LXkmavgCdutF8YSioVn1gjoy6nteba0TJblCvOpuBI4zbRYv8vX
         zO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769602769; x=1770207569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRGkP5+YEwarPAqoRUSfhM+YSpi6qiSMYzget0HX3O0=;
        b=kUSrnz/LQs80NL3PTuQY4qvn8lLtysEg4ovAbSTl6FSOoajomrtqVRiqixzq06BE1W
         28WaQ2bha5oJihhzn5yzPh9wunCp/YXWiwEKW2SJOFsVV8RgMXKSVAg4bPgF6a8VZWjv
         6F2KzYgRGDk9zWIU0zpnY7ZQUVVzoY7hSNKUjO/wJAq2XfCkuNUc2K9QXXYuA1i1bAAO
         9lki0N5Z/en5qLBOF5bduMzbcqAlvhkn4+SO5B47T/FBZy+IxRC9i4CG+7mr2jKvBATN
         wp79sOD6VEeoLgprDStyfEtuVEPyaJh9xwe8knLr5apbpFTAkn0SLjw1vxshZWY/Ps2z
         QXjg==
X-Forwarded-Encrypted: i=1; AJvYcCX233/KygUwyD8Ngl3oJ2rOQnQ+ecdhjqORe/eHVaNrXuYX/YFe6MM/ENBVysiCT+SXt3F/Dqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4nq8BJ9IwYCTeZFX381rC48ngRMOGFO1HGNCDNsB64FwM7qX
	i81P47ANnOSDq/2MzfmrAAPh2/pLmM/n+uViYN1Gtu0N38HNNqqq/ehh
X-Gm-Gg: AZuq6aJqsNltAcN1KNmR6Lw1tlR3x48TPQmUU8ZJ3NhEW7KqtZLlTh6+OOl/0AASltd
	LC5jbCBQ1nQPJ7+ylZSAVF60gNApQI72e0JO/n/BIIf+vBpcO67AxqL+vkMe49CWCQFwRkkOkir
	YJuEWD9jrJG3vkrlSV9+Q46oTtSBcjEWTNwlGBm27mXv5GYGpsjhHpf5HH3ut8idaITshNuWLUA
	FyQeogAJx5w1tFYni4u3bk+9MwlhYkCgMW8l7r0eK9C+wU2R3rjw3uE+IEdTd3wNEGmM66qrr6D
	fRzctr+7QmqUl6omH4DHL8yf9CEuhp3Vih0cBJSjgT3KOzH1f5gDjSTuCpaaQdCoRMW0VCIpNGl
	oFiSvwLYLAIzGe2j44q8TiLcepfgIRm8cCYUCz4pEsEwtpZFhdR350OoX3PbN3qkhR8TAfOS/mE
	wrMzY=
X-Received: by 2002:a05:7301:1016:b0:2ae:5fb4:c5f1 with SMTP id 5a478bee46e88-2b78d9e810amr3201379eec.22.1769602768785;
        Wed, 28 Jan 2026 04:19:28 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88c4sm2268876eec.31.2026.01.28.04.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:19:28 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: kuniyu@google.com
Cc: brauner@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jlayton@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	realwujing@gmail.com,
	sd@queasysnail.net,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH net-next v3] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Wed, 28 Jan 2026 07:19:16 -0500
Message-ID: <20260128121921.1761236-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAAVpQUBbdsNPkvL7JHrgqen7DM70S2VYTtgHx-kjWq3ZqB6uqA@mail.gmail.com>
References: <CAAVpQUBbdsNPkvL7JHrgqen7DM70S2VYTtgHx-kjWq3ZqB6uqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254237-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,vger.kernel.org,redhat.com,gmail.com,queasysnail.net,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FDABA11F1
X-Rspamd-Action: no action

Hi Kuniyuki,

On Tue, Jan 27, 2026 at 6:05 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> On Tue, Jan 27, 2026 at 5:22 PM Qiliang Yuan <realwujing@gmail.com> wrote:
> >
> > Currently, unhash_nsid() scans the entire net_namespace_list for each
> > netns in a destruction batch during cleanup_net(). This leads to
> > O(M_batch * N_system * M_nsids) complexity, where M_batch is the
> > destruction batch size, N_system is the total number of namespaces,
> > and M_nsids is the number of IDs in each IDR.
> >
> > Reduce the complexity to O(N_system * M_nsids) by introducing an
> > 'is_dying' flag to mark namespaces being destroyed. This allows
> > unhash_nsid() to perform a single-pass traversal over the system's
> > namespaces. In this pass, for each survivor namespace, iterate
> > through its netns_ids and remove any mappings that point to a marked
> > namespace, effectively eliminating the M_batch multiplier.
> >
> > Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> > Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
>
> Why two SOBs with the same person ?

- Signed-off-by: Qiliang Yuan <realwujing@gmail.com> (Personal email)
- Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn> (Work email)

My work email often has trouble receiving external mailing list replies, 
so I've included both to ensure I don't miss any feedback and to 
properly attribute the work. The v8 version should have everything 
matching correctly now.

> > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > index a6e6a964a287..50fdd4f9bb3b 100644
> > --- a/net/core/net_namespace.c
> > +++ b/net/core/net_namespace.c
> > @@ -624,9 +624,10 @@ void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
> >  }
> >  EXPORT_SYMBOL_GPL(net_ns_get_ownership);
> >
> > -static void unhash_nsid(struct net *net, struct net *last)
> > +static void unhash_nsid(struct net *last)
> >  {
> >         struct net *tmp;
> > +
> >         /* This function is only called from cleanup_net() work,
> >          * and this work is the only process, that may delete
> >          * a net from net_namespace_list. So, when the below
> > @@ -636,20 +637,34 @@ static void unhash_nsid(struct net *net, struct net *last)
> >         for_each_net(tmp) {
> >                 int id;
> >
> > -               spin_lock(&tmp->nsid_lock);
> > -               id = __peernet2id(tmp, net);
> > -               if (id >= 0)
> > -                       idr_remove(&tmp->netns_ids, id);
> > -               spin_unlock(&tmp->nsid_lock);
> > -               if (id >= 0)
> > -                       rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
> > -                                         GFP_KERNEL);
> > +               for (id = 0; ; id++) {
>
> Doesn't this rather slow down in a common case where
> init_net has ids for other netns since it is never dismantled ?

Yes, you're right. In the original code, we only scanned 'tmp' for specific 'net' 
which was being killed. Now we are scanning all IDs in 'tmp' to find any dying 
peers. 

If 'tmp' (like init_net) has many long-lived netns IDs, we end up iterating through 
them even if none of them are dying.

To address this and avoid the overhead, I can use idr_for_each() with a callback 
to find and collect dying IDs, or keep the O(M_batch) outer loop but optimize the 
inner part if it's truly problematic. 

However, given that this is the cleanup path, I thought the batching benefit 
(N_system vs M_batch * N_system) would outweigh the per-netns IDR scan. 

I'll revert to a more efficient iteration or use idr_for_each() to handle this 
gracefully in v4.

Thanks,
Qiliang

