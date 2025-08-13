Return-Path: <netdev+bounces-213308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8276B24801
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28375726BF7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4192F6597;
	Wed, 13 Aug 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTWhVgEB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0F21256B
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083186; cv=none; b=TdBLPW6wnnkswx+bwwsRgQEY1Ey71lE9bq755xMThSLEDMZyUua8SIDUVkrl3CblqjvfzppJY4mo9VqvRicJt7h+Q0/Uiq2xBGI1bd2WJk7AcAUjYQMqSL6kf2PF55CMFWcbCkGcYnwaG9/DDXnTS9xnvpx3hvktiW0QnXFQ/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083186; c=relaxed/simple;
	bh=cACGEQpaz7YsuDS/UFhXmMOeRuWHuV4oQT0r4/yYB/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAhVB52mFYT3DEvSRVRdsehB4vsdDq3PMdjn8RbRqbK/zPujV5GPLUAIrHbbK0wT8gWSM7MnshbM95G0+lw3899x1jrWWDkYS6ev3cLer3No3SXJ2GXeUQx5XMN/P16ZlfAogf6FKItPKgkugaMURRcSMIMLLw6Kq8wjpYpbWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTWhVgEB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755083183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biyu7frguHt914mTfrDuMKsFjm+yH8cJtMl8byXbQu4=;
	b=fTWhVgEBrtVoqWsjepMNZecR3FJMkghVd8lxStEsPpWGfZrOdaYEYxJ0D9dBLuzf2mgeZh
	wmVDIHX51vZm6IwSxuEjKbV5P+MqWipOwR/8Q0gRCzbTW00uYWFjPHMvrLELTyQkVJxKm9
	RHp7FWnD2cinW9wgDVtfouA0bqcfXz4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-NyvbuT_tP-iMzl6PXr-lPA-1; Wed, 13 Aug 2025 07:06:22 -0400
X-MC-Unique: NyvbuT_tP-iMzl6PXr-lPA-1
X-Mimecast-MFC-AGG-ID: NyvbuT_tP-iMzl6PXr-lPA_1755083178
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6159e6b4ed7so5656453a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083177; x=1755687977;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biyu7frguHt914mTfrDuMKsFjm+yH8cJtMl8byXbQu4=;
        b=G3Vd3qiM4APh1tHamMheu+Gk+858Naue5BNf/cMeZ9z2+RgkF9NX52q7Rl2KC0ee1Q
         d1nkUhm8lRaF48UtySxBaY+cVqfEMZ2Tk6UzcM7o6nKdJR0oQ7kqU/Z2uKG4NjvlMCpV
         GujB6puZZHQ/ywwGPyPzpxfPHUpnLtYUFWSEISVZyo3pqFTfK9YpPhyi7uug20vRF+S/
         ooRNzngaI1B+VkPwhN2FdQeASAO2OjOj/PqZw9XFPXrFZ+AP2UL/emSY7vI8sTAbanLf
         HhJbrfjiku4ZASekUDBt0FvwRUSf/BtBF6xv6wH40MFhgGvMtPDPXOjT0XiTT+Jbn9qE
         /65w==
X-Forwarded-Encrypted: i=1; AJvYcCW8N9TYvhFAlMJGEsH3KVntXjUjtiB8QsYgYMYhk6OhLFbcB3a8htecDhO3+yfI0h1J5OqHHrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh210eekG2Lubzc21fg9yFUT5XqlBDVTKz+HBD3QFlmhZcUAar
	uRxcztYef7pxigGWxf2QMAKSuNBmZ8NMiUG3PseRfekvsHzmQo0b4OW3E6wi9OChLhibQPTyMj/
	JNYk1LYLN7LavVfwajeRSLFlxqNuADzBFVwtLCPRaqBq8oBjYVCjH6Bnyjw==
X-Gm-Gg: ASbGnctKS5xNV5Q9N3dqXr4CiSg1GcGPbjCoqJQgJu6qB0A+l2Ib3XcpYf1J9CKxDVK
	upUTl2CRDJz1FsrdH42L6H/jJoolfVPyouac9EEYWEDJxXLBuYgWGCphSLAxNhWyHhqf52EMyhi
	IXh92jc6gtEoEbZMyImrpd5Cc5j0H/e1DOpe3S/CodyNBCr82KKf7qOCREwJgnx9N98Opae3m4g
	oBBlqiJBoth7V6H+h+Tw77RkWzxL5TjphkGNV7w6DGvyqcANXbJKRzSfs8LJ9YBrVlC6W7jVuT4
	WuwSK/oUuOQZE7vWD+hcbnnK47Nyyyi/FAskY+4owrt+na2Tk+YP43MNzLdfDHs=
X-Received: by 2002:a05:6402:34d3:b0:618:586:34f1 with SMTP id 4fb4d7f45d1cf-6186bf66d00mr1752554a12.9.1755083177563;
        Wed, 13 Aug 2025 04:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG51LxYsiTqLYfdMBwLNCAjQxd6AZT09DhjoLQ9/EerHpDBdkNT+yVQ1yrUJyBGopCMMUPdaQ==
X-Received: by 2002:a05:6402:34d3:b0:618:586:34f1 with SMTP id 4fb4d7f45d1cf-6186bf66d00mr1752536a12.9.1755083177136;
        Wed, 13 Aug 2025 04:06:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm21081059a12.36.2025.08.13.04.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:06:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4DFFD19D183; Wed, 13 Aug 2025 13:06:15 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, lorenzo@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, michael.chan@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, marcin.s.wojtas@gmail.com,
 tariqt@nvidia.com, mbloch@nvidia.com, eperezma@redhat.com
Subject: Re: [RFC] xdp: pass flags to xdp_update_skb_shared_info() directly
In-Reply-To: <20250812161528.835855-1-kuba@kernel.org>
References: <20250812161528.835855-1-kuba@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 13 Aug 2025 13:06:15 +0200
Message-ID: <87qzxfjxaw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> xdp_update_skb_shared_info() needs to update skb state which
> was maintained in xdp_buff / frame. Pass full flags into it,
> instead of breaking it out bit by bit. We will need to add
> a bit for unreadable frags (even tho XDP doesn't support
> those the driver paths may be common), at which point almost
> all call sites would become:
>
>     xdp_update_skb_shared_info(skb, num_frags,
>                                sinfo->xdp_frags_size,
>                                MY_PAGE_SIZE * num_frags,
>                                xdp_buff_is_frag_pfmemalloc(xdp),
>                                xdp_buff_is_frag_unreadable(xdp));
>
> Keep a helper for accessing the flags, in case we need to
> transform them somehow in the future (e.g. to cover up xdp_buff
> vs xdp_frame differences).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Does anyone prefer the current form of the API, or can we change
> as prosposed?

I think the change is fine, but I agree with Jesper that it's a bit
weird to call them skb_flags. Maybe just xdp_buff_get_flags()?

-Toke


