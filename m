Return-Path: <netdev+bounces-129832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD59866BC
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64213B22A04
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9911465A0;
	Wed, 25 Sep 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WiN/qngd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B9146589
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291751; cv=none; b=kUi84TWUCbI59GtBFkJwafb2znzqLAM2YfZrMn3Mfgufl37oL7IJ9QredJ7wLVWPTL/g11oBoYuc0shb8I9Ius/PdyHgPzt0dHhlPKA6n2TdRfphlOZMKhYZBFS4R9P9RepMcoHCZwMoikLu6vhTT3x9I4xFuwwQRWT7k5JJQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291751; c=relaxed/simple;
	bh=o1/bCryezMWjHmeYHUAy3ZTGm7pDh9YQkH78LTeoFwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjCg1BTvJ12lfaM20k/xZYVpEOJOFRgb40uRqGYNhEhdNLbRvIYUIGO5j0FYmLz8PG9UKQsCs+8Gy3g9iG/HnRPcOysKP/QOYw3Y8dK56aiyJI0hS70dUHJPbsFzGvDHIsmWLPrTVKqWhOrdcz7BoNreplNzKBTgSGRduJ8WTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WiN/qngd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2054e22ce3fso1511535ad.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727291749; x=1727896549; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWY9EjlAxuPy5D89vqcNXWH+sw5yXyxDgjqEksBw84M=;
        b=WiN/qngdQMLlh91INXn98yZHjrFST5qsYZnqStxyUpT/lKxAAt76BfHukg8GKAstti
         uRjyZiGb/zyzhw8DwGqNwaG0wmjpBazDHw+d+kr5DgQ4Lwk0nSlzQnu3YPN22iKYX03K
         69AzaeTnvhY+DGpdTS1YB7q4Yxgxdh+zn/Ttc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727291749; x=1727896549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWY9EjlAxuPy5D89vqcNXWH+sw5yXyxDgjqEksBw84M=;
        b=ICPiIIkaKRuJIyQhRGoP4MmHlB9Hj6PEUUXbj6YHaNeLaNw6vEQcUP5lkOR7viFhgl
         aud6CG37XVcr6PuLTEkbY5AfouwFad0m2fxKy+vbuXyjWIa+yGvIjMVz9s/Y1ZFWBFzf
         dGu1+U7IIo38dTvoKaDN8pImXaOg5mC4T6ypuHANSZzjl1JyaKFAUVbTMjOfM5yk41P4
         4E7oo0nTT5EMLhhuErOkYvoAa5hIREg38+vjSIav+MQgErtVFe9dTDf3o1mdvoPL9TTM
         iJE6u0q/7sR8ny2SAZ/yBMVM1yEPJQPfV7R4UQW+jRdxTpBtnxmicxCfDe/Ib/GHxPU3
         So7g==
X-Forwarded-Encrypted: i=1; AJvYcCXlN5Ag1XfACAReNB1CuqMP8rhn7p5jkQg7leX61trdD7gPhyo1UvVG4PajnxUq/agriObAa3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DoDHzxHRDAaO8Le2I7FqyQAajdZVVPTrYj7x/FrMgYfMFdIl
	QuXGwSUikf5JyH1gRlpXNEpKb8nSTM88zAYvvsrDAovt3/fcR7w+7mnDNj1Hp8g=
X-Google-Smtp-Source: AGHT+IGz/6cEuIGzr9wZxQhRvhJTWOp0/cKlLVBzPTv9rhVrs8nJBen2BIjWNP6M/4Q2f4f9HY2bSQ==
X-Received: by 2002:a17:903:32c6:b0:205:7180:bb59 with SMTP id d9443c01a7336-20afc453098mr37540545ad.21.1727291749664;
        Wed, 25 Sep 2024 12:15:49 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1857caesm27268835ad.275.2024.09.25.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 12:15:49 -0700 (PDT)
Date: Wed, 25 Sep 2024 12:15:46 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/2] net: add more sanity checks to
 qdisc_pkt_len_init()
Message-ID: <ZvRhYkwF4xL7tb-m@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	eric.dumazet@gmail.com
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-3-edumazet@google.com>
 <ZvRNvTdnCxzeXmse@LQ3V64L9R2>
 <CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>
 <ZvRVRL6xCTIbfnAe@LQ3V64L9R2>
 <CANn89i+yDakwWW0t0ESrV4XJYjeutvtSdHj1gEJdxBS8qMEQBQ@mail.gmail.com>
 <CANn89iLkpP42EFRGmFUsSQv+ufNA=4VmSp6-1NJBBpm0kTjw7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLkpP42EFRGmFUsSQv+ufNA=4VmSp6-1NJBBpm0kTjw7w@mail.gmail.com>

On Wed, Sep 25, 2024 at 09:01:23PM +0200, Eric Dumazet wrote:
> On Wed, Sep 25, 2024 at 8:55 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 8:24 PM Joe Damato <jdamato@fastly.com> wrote:
> > >
> >
> > >
> > > > git log --oneline --grep "sanity check" | wc -l
> > > > 3397
> > >
> > > I don't know what this means. We've done it in the past and so
> > > should continue to do it in the future? OK.
> >
> > This means that if they are in the changelogs, they can not be removed.
> > This is immutable stuff.
> > Should we zap git history because of some 'bad words' that most
> > authors/committers/reviewers were not even aware of?
> >
> > I would understand for stuff visible in the code (comments, error messages),
> > but the changelogs are there and can not be changed.
> >
> > Who knows, maybe in 10 years 'Malicious packet.' will be very offensive,
> > then we can remove/change the _comment_ I added in this patch.
> 
> BTW, I looked at https://en.wikipedia.org/wiki/Sanity_check
> and the non inclusive part is at the very end of it.
> 
> I would suggest moving it at the beginning of the article to clearly
> educate all potential users.

Stephen has provided what was needed, which was: guidance. The
guidance appears to be that code avoid this phrase, but commit
messages are of less concern.

This was not clear to me before, but it is very clear now and I have
learned something for future reviews.

