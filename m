Return-Path: <netdev+bounces-205105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F22AFD672
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C817E74C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0EA21CA0A;
	Tue,  8 Jul 2025 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpfAMTli"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12021ADC9
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999004; cv=none; b=tLapyGVo86zhRF0A8RiCBBa5vZhGb9S92OvPQ7AgWDBtyOwpwbxjolQxm11dCOtdVaNh/SUHW9MeA2bnnj6jSwb7bM0LG7Q0KSsbVy3Fn2DCIqyYg/2zzutlj9If0m9mqKZO56O2LGyExXKA3Wkylyn9CQ331KqeY10DBsPR4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999004; c=relaxed/simple;
	bh=6D4k5enuBtf5mq7C/EEEecxyB7anJEyKceYtHVTwMho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqlY2ALgjCT7UH2Z4TGCp/bFWCxOpuiklU3JhpHQ1fUvc3i5mrL8/6lSNYR82pOrPefMGyhDNyt2C0VwCbz++3HIQ2J4cGQ3cVgPipiuS1urMBvgmFmYJR/WvqZGWZaev92LKbeF+ElKQWMTpVmop1JeofcIJR2HMbwbeGjfZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpfAMTli; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751999001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5S0edA8YlfYIhnN0SMQ3uKgY85pVF0l9tf9Kb7Nabws=;
	b=YpfAMTliyPlWq1oi55MyI1m+IFAVIRcv4jZdf6GTI/wI8+3VNjVaGCkfZYIyIO1VLcDN6w
	PSZfkWvNpSQoq5QEJGsc5HpGC7fzC3YuTfFJFhNpzVG22o5cJS9n739CHrHrPsWAgRsUEm
	yBqn8X1Hna0hAt37ZvwfYH2rObdCZqg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-abG7vr7rO9S32_tAYiLQwA-1; Tue, 08 Jul 2025 14:23:20 -0400
X-MC-Unique: abG7vr7rO9S32_tAYiLQwA-1
X-Mimecast-MFC-AGG-ID: abG7vr7rO9S32_tAYiLQwA_1751998999
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816cc58so1992486f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 11:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751998999; x=1752603799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S0edA8YlfYIhnN0SMQ3uKgY85pVF0l9tf9Kb7Nabws=;
        b=GcMDmc6kT0gztFlGlTP171dP61DHDTd7ChDiai29c2tBuNVBMm2lcY9JVtXx69c0jj
         /gJ63V+JsAzQlgSQFDiyI6od444ikVrPM1EdcdpHZry3u2wy6dky6n46WlqKOYckomAq
         Q+brmARKtSkl/j1ChScjEojHC92QEbKOzfQXyY1XYMZVs2BLiqCOabRdRq/ygVgrIvRp
         T6mPZ+7gwihwrIAGi7bgzLzRw5SMY1bZZSZiOOhdTCIFSZEfnbdAIr8SyHpHeYIjlhx5
         GuKFFknb6twzqSQmV+VCIenEtTjH9Ll9gYybWCViRV8LEkp092ncLa0L9Q4ARV6J2nX6
         A4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDF+9YdB3Pp4KEsziIi3nX+2UmS+lj+obZ25qyA16fOH8zmwlzV+rYHQQp10+gaNw7v0DDiW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1R1M0rLbPzlm+ymZRJ4BYF0XZEHOqomOxZudGHNColkVUE3M
	UcgOSi1ZnfOPr5AjVPJCH1Ht9z5mwc4ZuFlEiNvti7SR/EYLMcb7vzkU14shTcczi9s4HD3L+q9
	2/mZvLOLDB/Y3htXcP9H+ABIC/vSz2rgqFGvO1MVQ2m9ZhNIsLSxYhMuhVQ==
X-Gm-Gg: ASbGncue795xSZ4oZuv1PKDnxoqhJJbGxkJuXeayks3CU+MSAP249FyNQJo4ErAnDHZ
	QEI/1rb27Yad/lkew9e5jLFEXsO0A6+u43+rtD/I+WUMjV1Abjg4PZvPP024N3HpZ20eKZhj37E
	ri5+/O28VUzktK6bbkyA8WZwuFAnXKZTnymJK9bjQ0HShJrEPtKVIdpUcknVqh6l7jtnNTUhhyd
	07AZQbUgI6awdk2inW8OjEhDYUUHCWknqEIoBMk1SLJfCYyax9qmJ89opmxaoGUrI4hHEh5k5g1
	JxUCxC/f9dAtGB4=
X-Received: by 2002:a5d:526a:0:b0:3a4:e8c4:7a78 with SMTP id ffacd0b85a97d-3b5e321cdd8mr321520f8f.52.1751998998718;
        Tue, 08 Jul 2025 11:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgvwVefNfgyKFgRcfoH7Pj+/c+/lJ+0aJ6H+ylUKueYM0evW6M90xHn5AQ4O5gJ9Pj8RG9wQ==
X-Received: by 2002:a5d:526a:0:b0:3a4:e8c4:7a78 with SMTP id ffacd0b85a97d-3b5e321cdd8mr321507f8f.52.1751998998323;
        Tue, 08 Jul 2025 11:23:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472259842sm13692785f8f.72.2025.07.08.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:23:17 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:23:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 net-next 0/9] virtio: introduce GSO over UDP tunnel
Message-ID: <20250708142248-mutt-send-email-mst@kernel.org>
References: <cover.1751874094.git.pabeni@redhat.com>
 <20250708105816-mutt-send-email-mst@kernel.org>
 <20250708082404.21d1fe61@kernel.org>
 <20250708120014-mutt-send-email-mst@kernel.org>
 <27d6b80a-3153-4523-9ccf-0471a85cb245@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d6b80a-3153-4523-9ccf-0471a85cb245@redhat.com>

On Tue, Jul 08, 2025 at 06:43:17PM +0200, Paolo Abeni wrote:
> On 7/8/25 6:00 PM, Michael S. Tsirkin wrote:
> > On Tue, Jul 08, 2025 at 08:24:04AM -0700, Jakub Kicinski wrote:
> >> On Tue, 8 Jul 2025 11:01:30 -0400 Michael S. Tsirkin wrote:
> >>>> git@github.com:pabeni/linux-devel.git virtio_udp_tunnel_07_07_2025
> >>>>
> >>>> The first 5 patches in this series, that is, the virtio features
> >>>> extension bits are also available at [2]:
> >>>>
> >>>> git@github.com:pabeni/linux-devel.git virtio_features_extension_07_07_2025
> >>>>
> >>>> Ideally the virtio features extension bit should go via the virtio tree
> >>>> and the virtio_net/tun patches via the net-next tree. The latter have
> >>>> a dependency in the first and will cause conflicts if merged via the
> >>>> virtio tree, both when applied and at merge window time - inside Linus
> >>>> tree.
> >>>>
> >>>> To avoid such conflicts and duplicate commits I think the net-next
> >>>> could pull from [1], while the virtio tree could pull from [2].  
> >>>
> >>> Or I could just merge all of this in my tree, if that's ok
> >>> with others?
> >>
> >> No strong preference here. My first choice would be a branch based
> >> on v6.16-rc5 so we can all pull in and resolve the conflicts that
> >> already exist. But I haven't looked how bad the conflicts would 
> >> be for virtio if we did that. On net-next side they look manageable.
> > 
> > OK, let's do it the way Paolo wants then.
> 
> I actually messed a bit with my proposal, as I forgot I need to use a
> common ancestor for the branches I shared.
> 
> git@github.com:pabeni/linux-devel.git virtio_features_extension_07_07_2025
> 
> is based on current net-next and pulling from such tag will take a lot
> of unwanted stuff into the vhost tree.
> 
> @Michael: AFAICS the current vhost devel tree is based on top of
> v6.15-rc7, am I correct?
> 
> /P


Yes I'll rebase it soon.


