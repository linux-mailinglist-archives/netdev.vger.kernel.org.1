Return-Path: <netdev+bounces-143310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2629C1F1E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06E11F23F76
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479F1EF0A8;
	Fri,  8 Nov 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxcpz5I4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F91401C
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075850; cv=none; b=BgiX/RW+G0FRZCt86lXlRXPxKVTz7A3uG0wY1SMW+qkpXWC9G/w7FUapiLxU9H5JyJjoVR/khMAnLKxvcUw+teLmaJyrBQB/FCAvLQManlVHu9RzWuOdGGRXctN5wPnbJHMnjZsQsSUuyXrOtZZ/1dJQvpCEURtREaglx+GtG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075850; c=relaxed/simple;
	bh=YuwBYsJq0KBCmnivhaWQ41aC/wglLxjBYIhQgEV67DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYN8XEaOVYjZWpmyURqsuY/PITr16Zn7cJGb1Q2iTlgEwjpL0WF2WZiTb3+1lZlGGFvXEL12OlMCRkK+ss5+/29fFkCAFDOp3RV0ZotBQUNtoXXhApIQLImN6mOvP9Viz/+9bKnLxv2aFCuNVPXHkKVtu/LRusrlQOl00fxkXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxcpz5I4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1544369f8f.0
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731075847; x=1731680647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WcPs+askfMMn22qUlGL2WJpTR9P2vP0G6/Ezh6Rfo=;
        b=Oxcpz5I4CO19boDWMS/2HFpp/WDG2YJQXxAxbF0wQPb6F6t+fljaIQEhttfB05WeyG
         QE+Tueqg5d52LcE4rITgOoNV7dhl4+M6LJ5i7egcJfqT/4VJay/jBmJjw+9eB/bo9zpT
         lP8EWliHD0gN/6cXdmuFHAdkMr9ISQFDMDprswWopOPZuI3KIhOXCThLjCYs+D+4GoqB
         EimGXuU2xiSDmtjz7fjYItKOpqjSwf750G0Ku4MXfeMP7QjAnJnRqCarhcjZRCU2Tpc5
         6mNIWZ5Xhpslv86kz2lRpVODq5qIQ5YAr9kmXgJ/oWhkU7C98IK27RgbyD6IhOFHCE0B
         q2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731075847; x=1731680647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1WcPs+askfMMn22qUlGL2WJpTR9P2vP0G6/Ezh6Rfo=;
        b=vjRVk4VR+5Ml+k7hEp9uXzNv4bkByXe906wNbJ5IjS/K65X8gInkvKpk+PnxhPM4G9
         5UEwg/QL+G8Ws7+t1BAi59Bk9Ac4d6AXDpQ6hCim67IbAC43esK3PhRG5Jyj8qIUuxFz
         1d6jsLIfkz/WRHTpMqftOe0UADD9fwJCYQqrS/Xi0zuuzb67wyfEWFzVFDJ4D5MjPOZQ
         y/lgnyZr+PuiSHAyF1SmpwRMWfrn724j7L7aRLZzOR2ox16hMYrD2EKEKj/CpaaPseZH
         OxyuW6GoroKP/EM+0iEq+O08oJ569+2KJKJiZmbpKKssTeh+VOzWsTWHrja/xAxWgSaL
         jFng==
X-Gm-Message-State: AOJu0YyZwQ1ndO7OEVk4/mudV0G3lvH8yZO/lrVLwtENMXZ93+66FdDc
	vSdIcvyzV7sC8KhKUhhqTwSBroB5tDmFrPgUJoZacmQKsPzyzDtekygcYxKARG0=
X-Google-Smtp-Source: AGHT+IE/fhyJQ1kJjmFXji3wVEvQSj7AuP83sN0Hd0Kwp7AZayjTJlXPZ622HLQrfANkkYE3tnueNA==
X-Received: by 2002:a5d:5f52:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-381f1863404mr2552602f8f.9.1731075846737;
        Fri, 08 Nov 2024 06:24:06 -0800 (PST)
Received: from emanuele-al (mob-109-118-131-100.net.vodafone.it. [109.118.131.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e4d2sm5090623f8f.32.2024.11.08.06.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 06:24:06 -0800 (PST)
Date: Fri, 8 Nov 2024 15:24:03 +0100
From: Emanuele Santini <emanuele.santini.88@gmail.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org, friedrich@oslage.de,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	dsahern@kernel.org
Subject: Re: [PATCH] net: ipv6: fix the address length for net_device on a
 GRE tunnel
Message-ID: <Zy4fA07kgV3o4Xmn@emanuele-al>
References: <20241108092555.5714-1-emanuele.santini.88@gmail.com>
 <Zy3/TmyK7imjT348@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy3/TmyK7imjT348@debian>

I'm talking about the ip6gre. I agree that setting the hardware address to 0 is appropriate.
However, in the ip6gre_tunnel_setup function, the perm_addr field of net_device is 
currently assigned a random Ethernet address:

        dev->flags |= IFF_NOARP;
       - dev->addr_len = sizeof(struct in6_addr);
       + dev->addr_len = ETH_ALEN;
        netif_keep_dst(dev);
        /* This perm addr will be used as interface identifier by IPv6 */
        dev->addr_assign_type = NET_ADDR_RANDOM;
        eth_random_addr(dev->perm_addr);

maybe this is not a valid justification to set addr_len to ETH_ALEN.

I will make a review setting addr_len to 0, and will resubmit the patch after successful testing.

