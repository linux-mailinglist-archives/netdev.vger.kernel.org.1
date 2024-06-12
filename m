Return-Path: <netdev+bounces-102920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBE905670
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEAC1F22322
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76871802D3;
	Wed, 12 Jun 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpKSnAsY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4F1802B4
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204802; cv=none; b=YK6fvozkGeEqSsvp7s0p6Tjtr1jsHT8hvXJjFePUM77gRyN8aUPFgKp74GRjojmTuiK9Zk1YccAPnILcTH4SBodsdZLh7fUePlQS3d3dp/Jz7EGKjEHO7UdavNDAbej/KNvS5EUEDwVb47h25N/bi1Rm4J6HvzgZqRDld6WxKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204802; c=relaxed/simple;
	bh=0eHVEB5pAxp11dm2HUruK3VO3gn39LNxtkdQM8Bhig0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji7u1WTYyFEFDPZ5gP8+Ksjgj718qVf+Q7z11uc38jaJI1Y6vsjkldeXW2rneVd85FS1awu63WdwInBkJgTWEsZ6CVEKDfWYvxdxn6nkse/wuGaT5gmvHrnncaZ2WZn/gzOtzKi+ZF5/cY75RGdax1tSrpM5+bDnm3ZC09stL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpKSnAsY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp8tpOuWLrT8Dd7Q1BYypdXJ8eG6sBxcdpUi5JUhFuw=;
	b=DpKSnAsY8M/QmaLexUM7ShC3l6DflZbhQVLovB5j0u43hPXiqhgVog4sZ69TIO05/Ls5PB
	3EvbkAcBjw1nW+qUt6TfaQetiMp7Q/eX96EsPSsX6MRFzoniRcXnTUzYvti9UNKpOea/4I
	YT3+9OJMQNHsG6v28R7VpHTMsuRoYI8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-SItKb8ekN5GNE0D1LlShvA-1; Wed, 12 Jun 2024 11:06:38 -0400
X-MC-Unique: SItKb8ekN5GNE0D1LlShvA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f1f358e59so584632f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 08:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204797; x=1718809597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp8tpOuWLrT8Dd7Q1BYypdXJ8eG6sBxcdpUi5JUhFuw=;
        b=TWRSgYcQeHXFfg5n6XrVOeEh7veBycevqToBOuc4WMQeiWGiApyVs8Sx24NIefmukR
         ZM2saXKxc6fhV+YLl+rgKbjtCTVsLQvAMJ4tgn0+IV8QVPXC9cFHYEYVKFwuOCIJczQ4
         xbKQEKCS+XmbB6UUW+BF9WCp56kLQ54KU7c5t7jWF2tuUu0PJgDLtW6ePvuk7LY0zUVS
         5aXz0bRx/8RVa+VCPLmep3C5+/QH3vfvlrQbhouvrVeja7wFJiXVs0eOREh1b4bjmuzj
         okwI9IGXVhk/7yiXXNwaK8obWJEIu624/MRfSeJHzvytO6dtbwKDqL8tYgChVRQWeziy
         bOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW83tvu+MrJZUHepHgyp9M/Dr0EesHMbfRLnFY+6Rce1X+TZHJZy7rMyBL5a6Ma1WBTksgzzrdnb/1VhroDEAYfInEDZx5i
X-Gm-Message-State: AOJu0YwQwb0Mi5azBj4DjPxYVdKeWH7uRXFQFEnbSTrizcvxMZe7D2dZ
	EwFYeCZBlWcqwCyY4KI8b+XeUzvVeS49XhqMrrX6Jve4JUFyUHbN3e3Zl9kWfjuFIAgC7HkPOVe
	/JebfBA7vzSe7KJr0NAWWM+8oQZIVgDGSAdnze4wsyUtqgTW8zY8mgNH3Y9uAMNVA
X-Received: by 2002:a05:6000:186:b0:35f:204e:bcf0 with SMTP id ffacd0b85a97d-35f2b27c669mr5653326f8f.13.1718204797244;
        Wed, 12 Jun 2024 08:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsmbOL8mSVB2bSnh6EQUk0V7ORdG70D+bjbg3nTZEcncKxeOFt330EglJquQWsox6O0gqZNg==
X-Received: by 2002:a05:6000:186:b0:35f:204e:bcf0 with SMTP id ffacd0b85a97d-35f2b27c669mr5653277f8f.13.1718204796670;
        Wed, 12 Jun 2024 08:06:36 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1e4075d6sm10290603f8f.18.2024.06.12.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:06:35 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:06:35 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 0/9] flower: rework TCA_FLOWER_KEY_ENC_FLAGS
 usage
Message-ID: <Zmm5e3KFxFCQzwzt@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611235355.177667-1-ast@fiberby.net>

hi Asbjørn, thanks for the patch! 

On Tue, Jun 11, 2024 at 11:53:33PM +0000, Asbjørn Sloth Tønnesen wrote:
> This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
> attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use
> the unused u32 flags field in TCA_FLOWER_KEY_ENC_CONTROL,
> instead of adding another u32 in FLOW_DISSECTOR_KEY_ENC_FLAGS.
> 
> I have defined the new FLOW_DIS_F_* and TCA_FLOWER_KEY_FLAGS_*
> flags to coexists for now, so the meaning of the flags field
> in struct flow_dissector_key_control is not depending on the
> context that it is used in. If we run out of bits then we can
> always make split them up later, if we really want to.
> 
> Davide and Ilya would this work for you?

If you are ok with this, I can adjust the iproute code I keep locally,
and the kselftest, re-test, and than report back to the series total
reviewed-by.
It's going a take some days though; and of course, those bit will be
upstreamed as well. 

WDYT?

> Currently this series is only compile-tested.
> 

thanks,
-- 
davide


