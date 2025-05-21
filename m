Return-Path: <netdev+bounces-192146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458BABEA83
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D3C7B1576
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1FD22CBE6;
	Wed, 21 May 2025 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCpcKFoL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4C125D6;
	Wed, 21 May 2025 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747799606; cv=none; b=a8yOUOA2BfJggGxYB+76T6pcvGvG42Jho8SkW35SqZQgsSCu6ZNxYxBBAyvtlzStXwTGqK1/PVJpnFYNoekv65R1ia6Hw6q9V7/Nuty1X0aR31jIbvdqYQSkVEp+lSkojqtTEQY70XCuqeaZUfpk1NraV3it2CCPj6YyaCuovFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747799606; c=relaxed/simple;
	bh=uN0PK1pCI8zFs5kwJl7M+Q4IBCNxtqAtqsshrp+ESUQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YCg2X96us/7p+Wfjt/nBgdMTT/brImBmLM7FGKwe6dKShb8CcbPAPIXLrLbEQz+1aeLmlB91zmgOpA9lgfLUl/sAxNcexuyqrxVRnaHlsLnogiMw2qQAVkPet8bltGX4utqWGoEYd+fktQNNEAEgq1mysktKa3KwF3Zy7SZsWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCpcKFoL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4769bbc21b0so62226871cf.2;
        Tue, 20 May 2025 20:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747799603; x=1748404403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZbEYKBV3q79Cazn681vY3jG/T2pL30mQVE5Gp1d1DU=;
        b=QCpcKFoLXeVnlMt/2zd7/ol3wuGpfnDiBxUbXZNld8kVM59qYkppEHif+yCoJbUppP
         VMSAPBigvBvZ/cRPE3YCrw54X02mglj0OZLP59DE3TN3eAK539SlWwqOJovNP6Qe0YEb
         6H8o7v3nUCtMajLLq/DbXqU3NmKWY43O1XBp0/1qEZJniIO5smcyhPUfrGor+FXziCJA
         W1dUkK+FwWdtq/X2I8uAhs/8P7lEWiojGsi2wVBuE7GcCZ8qCCy//FUw6xgcTmXCB0TK
         CHKTBe6+N9SCPyTNMkgOkEk1feq5rYXPAXfykTctadS42UQzTMIhajsQDnvdSu+sODpD
         ZU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747799603; x=1748404403;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ZbEYKBV3q79Cazn681vY3jG/T2pL30mQVE5Gp1d1DU=;
        b=f57h97YNND/i69fDYCVdyh52uloCH/TQZvsE7lTe9zFP7W4aZlzOXsDk4xF87i68nj
         /fKh4JVLyVAjyDSdAVvhZVKRq8BM8Z2LxXIbUhOcUjTzE+oB6uP2JX6eS9KfzgcRlvIw
         q7aeHXE9BKEht1cjDASMsLCUnFSYa7KCtVws+T7DtfMyZykrtMncvLAO12eYH/DRORKx
         d/T6xVtw1AdcU0hHmMc0Q8ZyIZznssX1JX8IPKGEvvywN/a4v6rfDxdgEtM7SnWt9l+7
         spzVrowvyVDJpjnt3C+Q8I+wHMgHjF86TkEzBnagrfX4JiftqwaNZntZmeHT8MXSY2JF
         TZyw==
X-Forwarded-Encrypted: i=1; AJvYcCX4K1lsb/4hWgxl7eCtz0BAkxm3ekpVRHTEzYBorzq2ZZ4au1UanXQdsunPKbmHRUoIL5e1pT1V@vger.kernel.org, AJvYcCXuyIrjlFVh9i118EqYHxA05hLGAKeVAedoom36FMOM1gSJeyCy/TmOb3NlKVsvbbRxx7dgD6sMHKL/8dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7py/Z+HYYjuWP6/nFXMJnhLbqLb6nBv/MehKvznDCuHmiK/5
	NrRe/qcsqOy5YS9J0DzltQelcp0+SQrCKNKMoad1Kkr4IZJMuHSVK3+g
X-Gm-Gg: ASbGncvlT9sXb+SbXP9lOHw9b55y0TAOTust3gxf8L/1iBHF+mMarrNw+4i/LhOMPmh
	XKVIT05MXBh28kZJxLI4rxw7jfQeWKd7onLisydbcF9Jkw/m5WpymkfwBTOhWfL9jhBM72F4PzS
	8PnHlZ8AO5QElN4QRIs9nlssvEYHljTz2sK5P8JOlIkFTuJDjxkMmdIJLPbADCgdNMMeQEpnsyH
	rd2Mc23MJqz4CicvC14cCamr8AqXMfeFJPxUtY2fi3OE6rIXtUOMbcY6pDm1ajElLeY/RRW7SHF
	oPMPb3+UEM9YpYoavqlG8UTMheb65hb9q6GKViE6tb3htShBZOwXZr1ZOX62ehlHmRdsxfCS9Nn
	tQRculZMEPKAsE+WW+7/QwB8=
X-Google-Smtp-Source: AGHT+IESrWP39DHX1pY0UTe5DjglWoa9J30nm/7lQtR/X9wD3DNK4I4MqcxNLEQ4EbPXyd1UIOCAtQ==
X-Received: by 2002:a05:622a:115:b0:494:b2ac:781a with SMTP id d75a77b69052e-494b2ac7ac4mr216382661cf.2.1747799603563;
        Tue, 20 May 2025 20:53:23 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-49ad551963csm15179831cf.44.2025.05.20.20.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 20:53:22 -0700 (PDT)
Date: Tue, 20 May 2025 23:53:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Message-ID: <682d4e3271490_9e43729454@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250520200020.270ff8b1@kernel.org>
References: <20250520202046.2620300-1-stfomichev@gmail.com>
 <682d3d5a77189_97c02294a3@willemb.c.googlers.com.notmuch>
 <20250520200020.270ff8b1@kernel.org>
Subject: Re: [PATCH net] af_packet: move notifier's packet_dev_mc out of rcu
 critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 20 May 2025 22:41:30 -0400 Willem de Bruijn wrote:
> > > @@ -4277,6 +4280,13 @@ static int packet_notifier(struct notifier_block *this,
> > >  		}
> > >  	}
> > >  	rcu_read_unlock();
> > > +
> > > +	/* packet_dev_mc might grab instance locks so can't run under rcu */
> > > +	list_for_each_entry_safe(ml, tmp, &mclist, remove_list) {
> > > +		packet_dev_mc(dev, ml, -1);
> > > +		kfree(ml);
> > > +	}
> > > +  
> > 
> > Just verifying my understanding of the not entirely obvious locking:
> > 
> > po->mclist modifications (add, del, flush, unregister) are all
> > protected by the RTNL, not the RCU. The RCU only protects the sklist
> > and by extension the sks on it. So moving the mclist operations out of
> > the RCU is fine.
> > 
> > The delayed operation on the mclist entry is still within the RTNL
> > from unregister_netdevice_notifier. Which matter as it protects not
> > only the list, but also the actual operations in packet_dev_mc, such
> > as inc/dec on dev->promiscuity and associated dev_change_rx_flags.
> > And new packet_mclist.remove_list too.
> 
> Matches my understanding FWIW, but this will be a great addition 
> to the commit message. Let's add it in v2..
> 
> > >  	return NOTIFY_DONE;
> > >  }
> > >  
> > > diff --git a/net/packet/internal.h b/net/packet/internal.h
> > > index d5d70712007a..1e743d0316fd 100644
> > > --- a/net/packet/internal.h
> > > +++ b/net/packet/internal.h
> > > @@ -11,6 +11,7 @@ struct packet_mclist {
> > >  	unsigned short		type;
> > >  	unsigned short		alen;
> > >  	unsigned char		addr[MAX_ADDR_LEN];
> > > +	struct list_head	remove_list;  
> > 
> > INIT_LIST_HEAD on alloc in packet_mc_add?
> 
> Just to be clear this is an "entry node" not a "head node",
> is it common to init "entry nodes"? 

I wasn't sure. A small sample from net/core showed that many do, e.g.,
napi->poll_list. But not all, e.g., failover->list just calls
list_add_tail immediately.

I suspect, and from that it seems, that it is safe to not explicitly
initalize entry nodes if you know what you're doing / how they're
used.

But whether that is actually intended to work, especially with more
involved debugging (such as LIST_POISON) and invariant checking
(__list_add_valid), I don't know.

I did not find any authoritative documentation that says you have too,
so I guess it's fine. But not ideal.

