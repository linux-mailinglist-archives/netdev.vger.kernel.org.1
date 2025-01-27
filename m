Return-Path: <netdev+bounces-161068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D8A1D1EA
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1AA165582
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6B715747C;
	Mon, 27 Jan 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7W64YOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855C136988
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737965338; cv=none; b=Rc5Vi/NnN+suo2tmPenJv+MittYwBRnW3vp8qTe+H43ObBWjQFvAFhUAq+uE8etZDi0sxRGELLk08KgLm/Zu7pbMYPU9kTE5ysPk6yMWaHiAeXlr/u6oKxlfrg0tNzoLeqBsnn7XSAXv3EE0lRmxs6xd8H+u2IGWjcHV7kNaf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737965338; c=relaxed/simple;
	bh=NutEGv7ydMEgZ7DYV/Wtfx9HWAPrAkHT94s5gX1eTcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE2r8rQo6QbrzdCUd/S4pj2vtAQoFt75z+rbkszX19RiNLHGYxjhPgtm6C3byDyx0PHpTbXdstb4uDkh2HOAd1Ogqna9mVZdxqDJEBRVODKjuzSnQa3zZdjR82C3ADjCApD8I1fhMwWJtHOQ/+lx3mVqNRR9We75i8aN/uSIdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a7W64YOr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43635796b48so25798885e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 00:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737965335; x=1738570135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWYiXgsLvVV1e1orODSh2w746KPmUGTOQuQSDmIPR+U=;
        b=a7W64YOrp37Lx1t++aEdYtqbEJrySdcUT4ZFS68xVzYS+0POnTw/PAdZxKg4wLBLFC
         58Ndwkv/qTr1e0z5BNmiXkpAxI11Vc4Hdiimy8WrPthUN5ReVmukA9In0Qz0y4Ez1sn5
         kuLj61sAZvPBICDithkoDFd66QSdmXHxgwvfXepU6lwm4Z405tO/Ttrx0freg04r7RlZ
         ksR5XSznbU58z7gULBbhiXDRUB3NawS+q/twL0UehPhIO6q4A9yiIR6pcYvIL4zD8mMp
         /ZftoJmolwHLbK9Wtl+OVDXNkIadiw6pdenUlj7uL3HRQdUoZRUJrygHX2wmQ3ZuiqJF
         iuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737965335; x=1738570135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWYiXgsLvVV1e1orODSh2w746KPmUGTOQuQSDmIPR+U=;
        b=mJSsiRYPa/hECCMKlqSSghXF2vSXfna3dWQAH3KM9tyTgiDCVVKtg0Gmv/0S2AyVSv
         46JQBjL1igMaNcg1qoiiG8Vq0pECj057DQZWDq5HlRYbr6wMGHkCMCaKB22Qq1kgklko
         yA1aiD99u4LuaervOO25sndMhPJohjGQVzfqXW7Qsza/ETiQcJtE0kr95gVNEG0QBMcM
         Do+KLxl8+AZVI6RK98ErnvA0ZwtzJefNeGEy9iF5lCl3A9/oOqefpwd2ECd8p0FUxyMn
         8Ir3l6UdmbPI4CQ5aom6w5p/1u/Pr/so/lsUeu3O8umwsN3zz1VcysjEZC2lGU+gPfqs
         ua7w==
X-Forwarded-Encrypted: i=1; AJvYcCXFQuzJg5YjNcarhUZ3pyayopu0cb9CdbgjZUZSCM3GsbwwHW1jZGcba2r6BmtUUxXZo/N7xq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBni44rxHt1KwzWAJ1munrFAXKJJQAjtRMQG33ZkNXzj97Xbw
	+fYK6JLmuAbINlQRolnBPDjcPTcnQCMOc64jhSk8+aJYX9OKoc9o86gPr+L55Uw=
X-Gm-Gg: ASbGncupkpIGNr3Yw+ML816QZp5dJA1PNvIrldVwKyX9TT3Gb38F2fYt1UPnCfqE7Xl
	Nx0f8aDQnLjy5pBFekPP29U1I854vkBmsmAkHFJK1sq0GKXwNQRoM8vC6YyCu6RBUwvOQF+m3Hr
	0AoXw4IXcMsZHtB03AToi3r9AzZ8mFccrpqbOea8YiOOHSz41T7XdonHBmDxk1OFxpE4DjqA8Ac
	9ASDR9D1l0n02tdrzpv+X/ZOwUOWBI8SmQ3xexcxFcyXGDRyOvWYgOUt9xAyIHRPnK4plYZJUO0
	tLPm2g3WAQ==
X-Google-Smtp-Source: AGHT+IFa1hKFQp3e/RknXB0728kIXUNC0R5l3qxtA53+nqYfrSq+qB0VtOMbJK3E0jCXfUAKaJNAnA==
X-Received: by 2002:a05:600c:3b87:b0:436:2155:be54 with SMTP id 5b1f17b1804b1-438bd052e25mr102079065e9.1.1737965335251;
        Mon, 27 Jan 2025 00:08:55 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd502007sm121370695e9.14.2025.01.27.00.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 00:08:54 -0800 (PST)
Date: Mon, 27 Jan 2025 11:08:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aaron Conole <aconole@redhat.com>
Cc: William Tu <u9012063@gmail.com>, dev@openvswitch.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] net: ovs: prevent underflow in
 queue_userspace_packet()
Message-ID: <740fcd03-9c02-4911-8165-a912a97a6556@stanley.mountain>
References: <4d6d9d9e-b4d9-42f1-aa78-1a5979679b2e@stanley.mountain>
 <f7th65nhggd.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7th65nhggd.fsf@redhat.com>

On Fri, Jan 24, 2025 at 07:42:26PM -0500, Aaron Conole wrote:
> Dan Carpenter <dan.carpenter@linaro.org> writes:
> 
> > If "hlen" less than "cutlen" then when we call upcall_msg_size()
> > the "hlen - cutlen" parameter will be a very high positive
> > number.
> >
> > Later in the function we use "skb->len - cutlen" but this change
> > addresses that potential underflow since skb->len is always going to
> > be greater than or equal to hlen.
> >
> > Fixes: f2a4d086ed4c ("openvswitch: Add packet truncation support.")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > From code review not testing.
> 
> I think it's pretty difficult to trigger this case.  'cutlen' will only
> be set by a TRUNC action attribute, which does a length check there.
> 

Ah.  Yes.  You're right.  I assumed that since we neede to do a upper
bounds check on skb->len then probably the lower bounds needed to be
checked too but that's not correct.  My bad.  No need to do anything
here because the code is fine as-is.

net/openvswitch/actions.c
  1402                  case OVS_ACTION_ATTR_TRUNC: {
  1403                          struct ovs_action_trunc *trunc = nla_data(a);
  1404  
  1405                          if (skb->len > trunc->max_len)
  1406                                  OVS_CB(skb)->cutlen = skb->len - trunc->max_len;
  1407                          break;
  1408                  }

regards,
dan carpenter


