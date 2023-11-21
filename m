Return-Path: <netdev+bounces-49529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808DE7F2475
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 04:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5EC282800
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4869134B0;
	Tue, 21 Nov 2023 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1p7IsLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D86C4
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:03:02 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cf69f1163aso7602035ad.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700535782; x=1701140582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Mm3c6uHkYoAtPLX7/bdMoPos4PeVz5VTiYrjzmR+U=;
        b=j1p7IsLjXRu65Pc4KCUX/SKemU4PlVN0lBX1fKYkQuXfmCkbaXsOWlLeq1JHEuGBEl
         YnhzP46VYzfF8rCcnKjrv8STCZezdmU19SOsog3s3byt0w2+mNP+52xoSN84g3xZAsPM
         2sl/9weesyagswGYC/5RKEuBAuP4kskumyaL4osCAFjj1AK+2tLXpEnLHvFYPh7w5XFX
         vtr6bB6pPUw5k2c/U4UJW/KrJLDXQuUdLRUv2TQRCPm3RSE/+hsJ9yCVDaoUYXV4I6ya
         HEkj1ZctC+loeMXJn5+3KNNx9v6Lk4emnRTlkcNnKkK+Nk+PwX+yI1pcKsCEURJvy5zr
         aL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700535782; x=1701140582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5Mm3c6uHkYoAtPLX7/bdMoPos4PeVz5VTiYrjzmR+U=;
        b=Lzw5cv6BgfauQNrqO8v2DN6Lq7FP0gumeyQtpEsT7KRAyrOHi1dl0Gy5OGKwIH4GMX
         w7R5wDjr+Xgsw5KUxl1ZBp+Q9b2Hh2gRxelY7cxppaqXdKHdFZmvEd6HwConoULKYtuw
         j7QJNj3ZKed+o4o6lXloxvi+0OwoDUIMIJmRkOLFcoXZt6V2qVVna9Ol6y9jVvCEs852
         9eIF+17h9XOYmjxoTH6KHvvnZHLZ3oSd9wrxp+8ApD+0s8n+e8lmM+KDlJhGl94tKo8p
         UrXVEZhqmkIcumUx85OGC95UGVIvsgG3xAX1ze/0neS6GIDOH+Q8CxagOKP47+0NJOKD
         d/cg==
X-Gm-Message-State: AOJu0YwQOKrmzJorcI/Q4h865Vhh1Jy78qRfiOXjwoV6+W/6GHm/4zLQ
	V394IT6I9MvPVzfbUMrVWLM=
X-Google-Smtp-Source: AGHT+IFJsIHGXgIXFRLCqDZpMjPUF01VkjJ8T3uBZqyTYj71+XVjImJ+eTs8zqzsnESOKqGehcgC0A==
X-Received: by 2002:a17:903:1212:b0:1c9:faef:5765 with SMTP id l18-20020a170903121200b001c9faef5765mr8311054plh.5.1700535781670;
        Mon, 20 Nov 2023 19:03:01 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903120e00b001bb0eebd90asm6737000plh.245.2023.11.20.19.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 19:03:01 -0800 (PST)
Date: Tue, 21 Nov 2023 11:02:55 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 05/10] docs: bridge: add STP doc
Message-ID: <ZVwd31WaAsy6Cmwy@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-6-liuhangbin@gmail.com>
 <20231120113947.ljveakvl6fgrshly@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120113947.ljveakvl6fgrshly@skbuf>

On Mon, Nov 20, 2023 at 01:39:47PM +0200, Vladimir Oltean wrote:
> On Fri, Nov 17, 2023 at 05:31:40PM +0800, Hangbin Liu wrote:
> > +STP
> > +===
> 
> I think it would be very good to say a few words about the user space
> STP helper at /sbin/bridge-stp, and that the kernel only has full support
> for the legacy STP, whereas newer protocols are all handled in user
> space. But I don't know a lot of technical details about it, so I would
> hope somebody else chimes in with a paragraph inserted here somewhere :)

Hmm, I google searched but can't find this tool. Nikolay, is this tool still
widely used? Do you know where I can find the source code/doc of it?

Thanks
Hangbin

