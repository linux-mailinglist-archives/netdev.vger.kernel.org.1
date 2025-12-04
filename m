Return-Path: <netdev+bounces-243503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C769CCA29E3
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 08:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 327EA301E996
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C51E832A;
	Thu,  4 Dec 2025 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgJECPpa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxE0la1d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E6398FAE
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764832599; cv=none; b=omPLqK2ewesY+5hFbFoV0VZgNT0lujp25xEPy/0/o/cEt3tCrhNfng3tXGtOlxUvkQRkpjZVSrTNtUV3CbBgL0KkotVZ/Sh8PiIjkZ0cAIzkwy2oWnNH41GFF46HERA6qK/1qrTmQiAlmX8TtNqJZATQnPgorcUKSCBpu0ORXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764832599; c=relaxed/simple;
	bh=CLc6rRrt5rpx3bjRc4ujzBdnkytoR5fSzVNCRnnUBQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmZ+bcTymYlB9PdPmyxD4DzbRNjIBTJLBeYcvXNTItviOtLFJjQWLl+egVACkYXnyjGBlOp93u7cqyrGzdigEtfmhP4WO5Sg+OZWFXtxo4kbR7fZLfAd5b+6PoXnaVFS0DWAcWOmscbXzbHfpDQwANWg4RZ7scHg5cAsEKsLoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgJECPpa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxE0la1d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764832596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3qXdsgNNXtCkS4bI00gjPKx1mZmExrwrEj4Ky8EfxE=;
	b=LgJECPpajlwhQrE+cq/MQvUqzjW38Jz7Wkp+CciaTAUroBJ/wKLr0eY+q4FixcYtYiBZSr
	tCsAJX3OlsghK9TTGW+7RXTR0HaW0Pxj/eID8i6Z96Dn/tCOh3tXs9Ydxp7VoOwJlLOnDU
	cvounp9iaWt/p2Chq+HSdxLbP+9DA1Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-ui7vYgSfNoKYRaAMxu1vCA-1; Thu, 04 Dec 2025 02:16:33 -0500
X-MC-Unique: ui7vYgSfNoKYRaAMxu1vCA-1
X-Mimecast-MFC-AGG-ID: ui7vYgSfNoKYRaAMxu1vCA_1764832592
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e2e447e86so295828f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 23:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764832592; x=1765437392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3qXdsgNNXtCkS4bI00gjPKx1mZmExrwrEj4Ky8EfxE=;
        b=DxE0la1d00W4+72bk+8BqqRmErv4tR6pkxp/R3aDh24pZX7smXK473Ec6LPVPRbE67
         yFWjHk2aRHC60uxOwEL9jM37ph5AwLF1GRoax9dAUQKqbuO2OfI/l8JDr3k/hM57VOQ8
         Z6WVzNYXwKUw7vWJoTPsxLt/EHKpAKWMgWJRuQOai4TJ6B7wyzFyjuuDo7RIl8c97D0m
         7qwQkNACwjJMTQ46Fp5MQAdWmyFg9iSNRP4NrAxB59jxJLhghT4eHWdEqfAdKU7eIxWN
         re/Pu4m/tjDEqtnfdPAijq97JfmPMX7TgnoAQQTfO/vMEu6THuII0SNmGHUh7jb9UfXz
         vENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764832592; x=1765437392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3qXdsgNNXtCkS4bI00gjPKx1mZmExrwrEj4Ky8EfxE=;
        b=suASQUfVH05hJrYBFp7lwrO4l/L/qECRvqBoagSU4qozzdnoEtyxhF4OTR+bRMUrn5
         TSkGG7inzPpAFwyaXLwzov5CX5/jMC+YX2pjareOK4vBCivv37rSm5eKo6fsnoXBTBFt
         kFuMU/O/na8OWtTLJ1kOU5AULagHTyXYti8OgtDGgsL/325OumsffV9SWrlp8Sk30Mui
         aWHeDmwWRb6+HtIQd7lsOQ8WWbQd56QupF2etO/lEhJSUhWnez1dIsdlDXFfaEvfUkLB
         VfSxa+jg4hU/5NcoNilR/3n0lDk63klSfcb+3y1dnSdjL+udTNoFpn4KBBxMlivXt497
         3Nnw==
X-Forwarded-Encrypted: i=1; AJvYcCXfnvZCSHv+DfCNkshEATd60NWKWYaTKMdG8wSMUsYDs2PpShxoDc4BiUuNOST/oUlVd7PrymU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9mplxzw4or96Ojckql8qDt83cLgbF655VPXJppoFrcHR/Prp
	JVjdxA2PhjhzHQZEnrruxrQuMxd+kFgLOSyxkdBBvIiw+t5eje4ebxWHYQ87cypix62dQFKlSZM
	CwCYAqjzvV5G5jSMw1jZ65f0Ic+gpZPkVruiie67vfuN888xpRzfKvYhO3g==
X-Gm-Gg: ASbGncvqpJabPkLXft8wupN/PCzGO9Nsr7jVHy9F0wnjO+MoMoQchEK0Z3NvtAhwy+G
	Ttol7e51PcOkMiJ8G+MHqCdCBAP4VI/dCbiUd+JTyu7qNAmSJHoW2hyVV1JvZCyQZpbWBECm/6B
	PHyZMHykaIBPevhQYlE0++XuzrSeZXc+Pqm6VccidsS/TIEekQPeoC0xJWb+8ylp5OELVewIRmj
	4fOevBu8ZgD82K2RKVoz2NOptYq77bqlu7HVTeRLcEUo6MlDFnokkfqxebdDokbZ1aqyiW8d1um
	mLiJOmezkXNFa66TA2lSxJCPoTY8sOxvKDLxlwAYeh4DfsK3hB1ajSRRzOs55DfRm33UUJwOOy1
	ROf5QcsW8DitIkKbadNIpEzqmn+IQ0YfofA==
X-Received: by 2002:a05:6000:1845:b0:42b:3455:e490 with SMTP id ffacd0b85a97d-42f73178df8mr4931945f8f.14.1764832592282;
        Wed, 03 Dec 2025 23:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO8y+eQr/B4UQTRlReyGmp60+FiL6uBEAkHCWcMo7Pe6ShugffTLjbf4mgxbHGRS9v9LpugQ==
X-Received: by 2002:a05:6000:1845:b0:42b:3455:e490 with SMTP id ffacd0b85a97d-42f73178df8mr4931913f8f.14.1764832591837;
        Wed, 03 Dec 2025 23:16:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222491sm1468677f8f.22.2025.12.03.23.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 23:16:31 -0800 (PST)
Date: Thu, 4 Dec 2025 02:16:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chris Mason <clm@meta.com>
Cc: Simon Horman <horms@kernel.org>, Daniel Jurgens <danielj@nvidia.com>,
	netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251204021540-mutt-send-email-mst@kernel.org>
References: <20251203083305-mutt-send-email-mst@kernel.org>
 <20251203160252.516141-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203160252.516141-1-clm@meta.com>

On Wed, Dec 03, 2025 at 08:02:48AM -0800, Chris Mason wrote:
> On Wed, 3 Dec 2025 08:33:53 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Dec 02, 2025 at 03:55:39PM +0000, Simon Horman wrote:
> > > On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
> > > 
> > > ...
> > > 
> > > > @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> > > >  		mask->tos = l3_mask->tos;
> > > >  		key->tos = l3_val->tos;
> > > >  	}
> > > > +
> > > > +	if (l3_mask->proto) {
> > > > +		mask->protocol = l3_mask->proto;
> > > > +		key->protocol = l3_val->proto;
> > > > +	}
> > > >  }
> > > 
> > > Hi Daniel,
> > > 
> > > Claude Code with review-prompts flags an issue here,
> > > which I can't convince myself is not the case.
> > > 
> > > If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
> > > as does this function, then all is well.
> > > 
> > > However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
> > > flows, in which case accessing .proto will overrun the mask and key which
> > > are actually struct ethtool_tcpip4_spec.
> > > 
> > > https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196#patch-10
> > 
> > 
> > Oh I didn't know about this one. Is there any data on how does it work?
> > Which model/prompt/etc?
> 
> I'm not actually sure if the netdev usage is written up somewhere?
> 
> The automation is running claude, but (hopefully) there's nothing specific to
> claude in the prompts, it's just what I've been developing against.
> 
> The prompts are:
> 
> https://github.com/masoncl/review-prompts
> 
> Jakub also wired up semcode indexing, which isn't required but does
> make it easier for claude to find code:
> 
> https://github.com/facebookexperimental/semcode
> 
> I'm still working on docs and easy setup for semcode and the review prompts,
> but please feel free to send questions.
> 
> -chris

Thanks, interesting! And the bot at https://netdev-ai.bots.linux.dev -
what does it review?  how do I find it's review of specific patches?


