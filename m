Return-Path: <netdev+bounces-152542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE09F48B4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65510167C48
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D61E008A;
	Tue, 17 Dec 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnnChtGM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74E2E628
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430651; cv=none; b=LsitSXwoxwlDNJ1U0Xql5vilO5YoNhLn2/6XUk+5Ye/DcohO/CfwQ3mavPuEdOX/wLh0pK1uF/RX/WzjZWqDIq525W0R/jT+FAXoUXA1Avb1R947iXQZFAlCPHAj8HX1Mxqn4odGj9LjBmt3BqJPdY5RLGJTPFl6z/EDAYLEyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430651; c=relaxed/simple;
	bh=JZDE+NNWNqD0eET4rUJjfrrqe6rtaXSck0bGsditkd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNy0ZruRU7jFos7XQOjRyx8M0ujsM+mRi6kpnc0jK1RL5Am7oQIMFpWHrQr28srwzxhr7ye46CIDuxAzRbojmwT0S7SM/rKGaZgvjYET6mah7LdWqgifcjoQTdM1w2at3TKETynY7PaTu2mkiHl7Pgcr3dyhym3yhQENWhvjtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnnChtGM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361e82e3c3so7004095e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734430648; x=1735035448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZDE+NNWNqD0eET4rUJjfrrqe6rtaXSck0bGsditkd4=;
        b=MnnChtGMWmKYzFzBDDkeAfaxVWS5uQlD9KLSSheX/9q5u7Fk/yRbqOfcpFxoEs3/si
         o8Dg/ln0L/Wz7eUdOz0/698g/xvP3liSK1iOvZ+9/4zY6a4jRS7mu8cgo7y9GKgeIUfu
         i154boCXsBru2432Oivh939csZlJ4OPPJ/RbhOSr3QZmaIUsHx0Bd1WT2xtrb3KvwyPj
         FR3NEDTWnJl+yHAkHwXE+apGqadLY8jGSwMAGoHz9b4+n0OvonDIBR5beKjL0Jzljowy
         WNa972b8UYfT8G5BACR5IVBy2ck96dEdw7deJBNBNyGDEvLjt1pToCcli9UQyEyi67C3
         Jk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734430648; x=1735035448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZDE+NNWNqD0eET4rUJjfrrqe6rtaXSck0bGsditkd4=;
        b=CUW1olG526g5r7m1r1eYJmGtyTjoAhoBhOFhN3Kp40azHuCUck78fhLkX65R3CY40A
         tv14Ha2xABmbbj3LdaWjf31BfZUbkODmyfkJ72iW6Yb2ZEtV2d21vpUIkJhXjM7Rkd3v
         4M3EiT+at9Fym3EQTkH2z+69jizGPZLYryzoZXoO1wQW1FeZnTYNUPu3oiWDmvTV8eKy
         3pasg4S+oSANgpBKHiJ4AoLrlElrzFdDv83Emav7fbtA/GqVOKjUpF0IOI46q5tOOkT1
         qQhbmbJJjhY5URiEhrZ1hJbn+LJvQuFZ0eEpi4JfXKTLZTmFAESholsY07/pnJKbt6mq
         MSPw==
X-Forwarded-Encrypted: i=1; AJvYcCWCU9/ddgcn7wj0nL8Q1JP8JjCmlr6DE6BJC06S35tFEGJ/60pFP4394WV+fDPbaP5sCibRDbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Ch8NCyySHwE17IbiQMdlS8gRr1RZcoZOLlUnQjHkcXba0n5R
	a+IQOgNLW725Gktduaqi2oyPrJ/m6G9BN8bug+8jG0LNmhqRG94D
X-Gm-Gg: ASbGncutaOLk8sy9509C5Kt7Uu9gvaYMgtNj1Evisg8OkKTLnDnHH5qpudKS9iD+Ju1
	u0yj+feSerdtNzn7+P7U5f/urS0TZ3PfL0C33pUQ3sFNWdPJoTmujVUsCd5xwq8h9U7bvJ/MF+2
	UityYrX1Rbrjqz00UvTQG2Cf1umvbKKDcfEyd1BPupcjBrMEVzIu6r9DEzpErnzKjnhcUfDGGE/
	JD9IFPAAgiNB2xStg3NFBdmWW60cLCbn0NLKLWaj8uz
X-Google-Smtp-Source: AGHT+IELwzkES0tHwMXRlY/FKRi1BQt4jVr4mhln4TF2u+OF9UIM/uuAwhB5PLLckqNPh1mPaAVaQA==
X-Received: by 2002:a05:600c:3b88:b0:436:1902:23b5 with SMTP id 5b1f17b1804b1-4362aaa6c13mr52257275e9.4.1734430647700;
        Tue, 17 Dec 2024 02:17:27 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm112299305e9.6.2024.12.17.02.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:17:27 -0800 (PST)
Date: Tue, 17 Dec 2024 12:17:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241217101724.v6kbmfqpq3kgyrd4@skbuf>
References: <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <20241216194641.b7altsgtjjuloslx@skbuf>
 <Z2CpgqpIR5_MXTO7@lore-desk>
 <20241216231311.odozs4eki7bbagwp@skbuf>
 <Z2FAUuOh4jrA0uGu@lore-desk>
 <20241217093040.x4yangwss2xa5lbz@skbuf>
 <Z2FL-IcDLHXV-WCU@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2FL-IcDLHXV-WCU@lore-desk>

On Tue, Dec 17, 2024 at 11:01:28AM +0100, Lorenzo Bianconi wrote:
> I agree it is unnecessary, but w/o it we must rely on limited QoS capabilities
> of the hw dsa switch. The goal of the series is just exploit enhanced QoS
> capabilities available on the EN7581 SoC.
(...)
> AFIR there is even the possibility to configure inter-channel QoS on the chip,
> like a Round Robin scheduler or Strict-Priority between channels.

So the conclusion of both these statements is that it would be good to understand
the QoS algorithm among channels of the MAC chip, see if there is any classful
root Qdisc which can describe that algorithm, then offload it with ndo_setup_tc(),
then assign traffic to user ports probably using a software classifier + flowid.
The ETS Qdiscs which you are trying to add here should not be attached to the root
egress Qdisc of DSA user ports, but to the classes of this unknown conduit root
Qdisc. Agree?

