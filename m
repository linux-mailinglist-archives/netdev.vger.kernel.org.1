Return-Path: <netdev+bounces-192394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC58ABFBB8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7215010BC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6122D4F6;
	Wed, 21 May 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdlqfkJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AA22B8D1;
	Wed, 21 May 2025 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846501; cv=none; b=Nn0DlDbhZQ0aTUF0nnsn3kcFfBfzyvfjxvmzBQPBHDKpmippwP+bXIr5PASfLjZKoQgXKrihvnQ+BDdWi2pf/gPIuagLN/JgFOmjeGRs1nDhW7WQeVYlwcfOi/Cc/SXYqEjUf39qO9JoZ8iqY56JlJdMIcKKX7o6E16UT+ONNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846501; c=relaxed/simple;
	bh=iBdO01+MJWdZZZwt6nKsyAe2xyhLK06UynHB6bZKuKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDlgxVvogwMhwvLQYMHkEZYSSfRo22oiNGAR/EFBfU7I10agmc1fAcZtxt85++bHooTatgECoAR6BLrA1fiblS5UEEBRDvxUxEMSnZIYkDOWxGiEMyuhhqWCRYpJdwSJnq5aXbXG563rckhMcS9w5doNiNcCketi5y8cFpcE3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdlqfkJ+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c9563fafso3548792b3a.0;
        Wed, 21 May 2025 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747846499; x=1748451299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqSusmLUTDDrAFmVvKIf96jCAPfZcQ7xzil/5W/oxZg=;
        b=LdlqfkJ+diEQblLSqHn13hjo+rVCIst8cVqX2Cc3pG2xKl6zjKdd8onsZKGXyegoQq
         QJv798artRhu1nW+QtwBylAMOYuanN2GjKTPoWizQhtotTJR1zFP01whd6WIg1N0AhpJ
         KDK+rV4M/PfZptFw0LH3BNxkhYYhH20b7PVQbVzmnNXE7+RGrugYadXSEZNK+y9lHlmi
         wyLzS3/wy8m0eEf+hKgb7jW7ok9vo7ldnZ7QQyauLG2dciWiv9Zg8hAGqr5gAqjA2qKY
         zeLBYZ3ydrT9iijdwxb4wf5HeXP6Tau9PMa9gnYiqxMCcJZB+oeokP/HuwNvOU4U3in2
         poeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846499; x=1748451299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqSusmLUTDDrAFmVvKIf96jCAPfZcQ7xzil/5W/oxZg=;
        b=VLzKVgEtFqYG8CzbXCeHrZJi8DWvwdza4phZlJLchq4g8xax1YeW2F/OkdgmpAqiMq
         4WiZHAeXeePMpdyv3qAmpCudrL6KwaEJ2CDhBJD11xGu5gwMJ/o1YhyW4spc6tJWfDzC
         R4Etmlc/iMxqvpQ1YGux0ecUVi4ji49Q7qW9Mz4c2MVVAWEVC/1YqDr51pCS6UP6ryWS
         KsljCagjr2XNeUE3zMSseSJu4xCCgy24nJWeAC3kZ/tTjGL2OHbIqzTdfE/5Z242/I4P
         vE0bqOckzShKPAKzg/zP7zAbrTYLPWw486QTk6YSsls8aF8BSGJPe6OcvTq6pJAfGF7g
         cCtA==
X-Forwarded-Encrypted: i=1; AJvYcCUOJwafFxE4sWfCYGpHNj+pTBbShLCkQYASw/MJXMpQsethxfy/eq4A3vlcfkeI5gxphSbA35wG@vger.kernel.org, AJvYcCW0v+gotHtShLAHJNzhk5AyYOXJppjup9M8DjbSMGgygzHuvjJtREk9HcZicF41/ELKnL1nZq5sEQo2fiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKYXOQO480i/opHDSTntn/3BZ2uWVsvOMMrX2T4FxXVu50+WX
	kJ3V5oYn3KZLFh+TQD9UE27zFR5nFDE14SvSvAai62LBEIXJBIogikU=
X-Gm-Gg: ASbGnct51L3eCf+MTwwM6FID/Er6dxK+tYbZ7m37I/yZ8kxMmO+iXoJF5IdhGryVsCe
	n1wIZg2TqHZZxX+SVR1u+/2hU+cUZz3m/+fLA5Y7PGRopz3etE0yLdqWN+bitfxnxXBjv/bBSxL
	e7FwZjv+af8Qz+IJ/c77vc/I6ijLNk3tvWZkto+JJ3OoS2ITF39l/YCk1uw0mLtv2vvNPyf3owe
	QesqweUqVcfD/Pc4HYOumBrCXhHlIJWRIV8NkrROmLsljjSOrhkHyqqsS+noOJdXY+d5DSQL6ZI
	meObSnOEfutsHbRp489nwcUTGyrZb+Tan4U8VEJ5RVOesKH4kbeErPqDyjFEEtxD/xeR+XBVxaQ
	Bh4hpeThySAQL
X-Google-Smtp-Source: AGHT+IGfzklCLmeqYyT1I2rx1b3ghkJtG2vXmy4752jBGeg1x8Q83XHAGiyKh1OrZ1mOTBPOTfidKA==
X-Received: by 2002:a05:6a00:a88f:b0:736:33fd:f57d with SMTP id d2e1a72fcca58-742a98a32e1mr23062791b3a.17.1747846498974;
        Wed, 21 May 2025 09:54:58 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a96defc3sm9859254b3a.21.2025.05.21.09.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:54:58 -0700 (PDT)
Date: Wed, 21 May 2025 09:54:57 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Subject: Re: [PATCH net] af_packet: move notifier's packet_dev_mc out of rcu
 critical section
Message-ID: <aC4FYWEtxCw25Uwu@mini-arch>
References: <20250520202046.2620300-1-stfomichev@gmail.com>
 <682d3d5a77189_97c02294a3@willemb.c.googlers.com.notmuch>
 <20250520200020.270ff8b1@kernel.org>
 <682d4e3271490_9e43729454@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <682d4e3271490_9e43729454@willemb.c.googlers.com.notmuch>

On 05/20, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Tue, 20 May 2025 22:41:30 -0400 Willem de Bruijn wrote:
> > > > @@ -4277,6 +4280,13 @@ static int packet_notifier(struct notifier_block *this,
> > > >  		}
> > > >  	}
> > > >  	rcu_read_unlock();
> > > > +
> > > > +	/* packet_dev_mc might grab instance locks so can't run under rcu */
> > > > +	list_for_each_entry_safe(ml, tmp, &mclist, remove_list) {
> > > > +		packet_dev_mc(dev, ml, -1);
> > > > +		kfree(ml);
> > > > +	}
> > > > +  
> > > 
> > > Just verifying my understanding of the not entirely obvious locking:
> > > 
> > > po->mclist modifications (add, del, flush, unregister) are all
> > > protected by the RTNL, not the RCU. The RCU only protects the sklist
> > > and by extension the sks on it. So moving the mclist operations out of
> > > the RCU is fine.
> > > 
> > > The delayed operation on the mclist entry is still within the RTNL
> > > from unregister_netdevice_notifier. Which matter as it protects not
> > > only the list, but also the actual operations in packet_dev_mc, such
> > > as inc/dec on dev->promiscuity and associated dev_change_rx_flags.
> > > And new packet_mclist.remove_list too.
> > 
> > Matches my understanding FWIW, but this will be a great addition 
> > to the commit message. Let's add it in v2..
> > 
> > > >  	return NOTIFY_DONE;
> > > >  }
> > > >  
> > > > diff --git a/net/packet/internal.h b/net/packet/internal.h
> > > > index d5d70712007a..1e743d0316fd 100644
> > > > --- a/net/packet/internal.h
> > > > +++ b/net/packet/internal.h
> > > > @@ -11,6 +11,7 @@ struct packet_mclist {
> > > >  	unsigned short		type;
> > > >  	unsigned short		alen;
> > > >  	unsigned char		addr[MAX_ADDR_LEN];
> > > > +	struct list_head	remove_list;  
> > > 
> > > INIT_LIST_HEAD on alloc in packet_mc_add?
> > 
> > Just to be clear this is an "entry node" not a "head node",
> > is it common to init "entry nodes"? 
> 
> I wasn't sure. A small sample from net/core showed that many do, e.g.,
> napi->poll_list. But not all, e.g., failover->list just calls
> list_add_tail immediately.
> 
> I suspect, and from that it seems, that it is safe to not explicitly
> initalize entry nodes if you know what you're doing / how they're
> used.
> 
> But whether that is actually intended to work, especially with more
> involved debugging (such as LIST_POISON) and invariant checking
> (__list_add_valid), I don't know.
> 
> I did not find any authoritative documentation that says you have too,
> so I guess it's fine. But not ideal.

I can add the initialization to be safe and add more info to the commit
message, thank you both for the feedback!

