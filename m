Return-Path: <netdev+bounces-183983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD42BA92E7B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F7E3A9BC5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A945222594;
	Thu, 17 Apr 2025 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="iIuShzUt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF119222571
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934236; cv=none; b=uigVFfow1/q1zja0ejum4RqZR1TYg5jgp0VM8mk5y2nlqQOICPkSl0UZEyxpoOrgdu3TNndo4E8OnUCSd98Fr0Um3fefTO83aCweqgQxWMYKWUTUWDtrIURFbBLA/UrgPpo1H8YW0OzTsyst3Qb5+0yt3Ff6jpV3NFmy3MN9GKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934236; c=relaxed/simple;
	bh=06wqFlIt2yf7O6pvffCzLE6iuLFghozPfXIqq5cM2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnUtHJVa3EBi3UJPXrAiE5fpIbAeljdPVoqVNBlzhLkz1lq6Tykvgg4WQF6qvYIQ2W5rwwr2dFJLYRxNm4F/vFvoWGVZIkSHXFipSyTp2iJAJoje8bN/3rm0r+p19PeKCijSfhRAIKiNjxu2MNb+YBOvmliPZ4Ottbsm7RECWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=iIuShzUt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2241c95619eso2842645ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744934234; x=1745539034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0dCIx+23zeXhuIp/i1MBELdaqZWYnVSQg2h+CzEaos=;
        b=iIuShzUtOwa9kcwzV+ZFiXGuQu+qSV6VJ3dYUB5BE1/LdkcWASX5USnEgSzqF8/U/z
         85yr1twZToWmEAMsGRY0rIgEE88YECNLN0+nTWjav0OB7tsQmqkn7RLG7XmCYeODBChy
         3Z9Xlbwzick7T7UFf+5Ff++vSjfSfX5qP2rIr/EAar/9yE8nrP4mJb7j4n4grjGRPq9d
         EHpHodKsszoL3Nf1jQ8YjbPmokuJf1QaDA6JwdFNokUq1XKrOs1eKzO47VtMsSDPBFWq
         KizAH1VByJisNuDqB/i4IVsyIBeXlpLt01Q38Y49wruqYAwpajFbwrgMw5BlM8g7nLm3
         sprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744934234; x=1745539034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0dCIx+23zeXhuIp/i1MBELdaqZWYnVSQg2h+CzEaos=;
        b=vzG3Pgpm29vrOKDQ85jw4K3kXXqBNt8TX6L3CIZVNkwlosrsfDjnt/7J6Drb8clDhw
         Ism50CaPUjORNN2IkXDNYNyvGNo7mNLB3zptVcXITaLR0HTO69ABUhQsgSth6hM9M3kM
         slhqh0tzCrHLk886YQlFMP5TUE8gVtFqxtyQpx+PIHNS6MOZK9j8KT9j78te+CfEVlys
         RIfIX/5//gV3tryE+/UPeHWRJ/5MXPiX+87GQiQTvocodo1VC7izpJEl71YxA0HVSa4B
         LNEvSUkVu/cBndIeXHzfns6Sw3vlqbB3s4vcunuEuOvRvn7SEoNQFLoI/N4v/kWXosBN
         uKDA==
X-Forwarded-Encrypted: i=1; AJvYcCVVep0iLI1JtfmxgkJO40b7CS64PZ2StAgYsDdH3KsJtgnQVLtzXwEZUV7K8p92JrJ3d8jGfmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Aqjdos7P5ZArgTkSi9r8DbViF6n8ap9yG1uQaLwIqAfxZRGn
	9Fh46wvWyhagTWnJeSiWGIeYXS/yB+0sKNVbBqKioFWeuqHN59umCIZLCz8Pz6c=
X-Gm-Gg: ASbGncvtDaprlcYFVxkFArYY93+5B7XD0E23WfRAaEVH+2BIhcOh0SdGwI/xDonNw1r
	M0a0iYz1CcK8+IMVTUKAH/ImIanw7a9IbsOOi9oM/yVdyh/mM68y9eH83jb9J95xRV8GakD1+8D
	QdVNm/Dm4XfbULpfP+6C3I7Y/5B7yvnTHrreDse+K/HUbEIWAOoR3PS+2taSxciUl+paMBTQLhA
	tUAS2NdgUSESGRB/8XNiCKe66AG3WDFHeKq1PTZzKmOC24VRCUfnQlfhC/XBuVWLzGt6VBuvous
	arsqkZHm2BwvQ2Hmap71dAv6aZxkj798XjV1xQ==
X-Google-Smtp-Source: AGHT+IEyeges0Q+A9GU9VfCdbdKZyaQgXlpFAM/VkFT6WA17RmTMNBRBhdobteISV8UeA/fq85tbdQ==
X-Received: by 2002:a17:902:fc8f:b0:215:2bfb:3cd7 with SMTP id d9443c01a7336-22c5360a8edmr4221325ad.10.1744934234065;
        Thu, 17 Apr 2025 16:57:14 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:2a7b:648e:57e0:a738])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf55fcsm6107075ad.80.2025.04.17.16.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 16:57:13 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:57:11 -0700
From: Jordan Rife <jordan@jrife.io>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
Message-ID: <aAGVV0JtJDMR1O0Z@t14>
References: <20250416233622.1212256-3-jordan@jrife.io>
 <20250417234511.39315-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417234511.39315-1-kuniyu@amazon.com>

> > @@ -3454,15 +3460,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
> >  				batch_sks++;
> >  			}
> >  		}
> > -		spin_unlock_bh(&hslot2->lock);
> >  
> >  		if (iter->end_sk)
> >  			break;
> > +next_bucket:
> > +		/* Somehow the bucket was emptied or all matching sockets were
> > +		 * removed while we held onto its lock. This should not happen.
> > +		 */
> > +		if (WARN_ON_ONCE(!resizes))
> > +			/* Best effort; reset the resize budget and move on. */
> > +			resizes = MAX_REALLOC_ATTEMPTS;
> > +		if (lock)
> > +			spin_unlock_bh(lock);
> > +		lock = NULL;
> >  	}
> >  
> >  	/* All done: no batch made. */
> >  	if (!iter->end_sk)
> > -		return NULL;
> > +		goto done;
> 
> If we jump here when no UDP socket exists, uninitialised sk is returned.
> Maybe move this condition down below the sk initialisation.

In this case, we'd want to return NULL just like it did before, since
there's no socket in the batch. Do you want me to make this more
explicit by setting sk = NULL here?

-Jordan

