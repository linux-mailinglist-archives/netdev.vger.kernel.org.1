Return-Path: <netdev+bounces-144064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A39C56AF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6F61F23D14
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5C230991;
	Tue, 12 Nov 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuKDTDkX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7BA23098E
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411255; cv=none; b=GElXQPsNYiJ2BYcfKppxSdCnnbo+p1YQs82oskDQ+QGZHI7LM9h+3PhdzXqTFcbabiI7gu0Auw+eYVMH1jpHcDO7A9yO+SvGjbmKu1TJw2PVcwfKf2kGwa02pGgaQocEAaiGHYpQbmNc3o7hpfvZG3e8UE3ARdz+jRI9b2suOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411255; c=relaxed/simple;
	bh=xyQvH19JUD2PMDR61qAfPZtcanGLhBpnQBqZpD9uVlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmzSHbowoWrQb+zZftokhWSWL1eTGnfN5EkYY1PQEgKRC/44rDbajw1QKyEsqwqDGnc3awHXyvlCKLQDxTve9eD9DNPB1iHeKDqFwo8F6MA0uql087t5C5NNm0To7joAX1QcsGPoIVIjTLUH9zH66PjNJt3CaFlx7LvEVajXjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuKDTDkX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so4604135b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731411253; x=1732016053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5p8lUFUH2waVn78UrKgyOw+mGXVmAuWD1Fv7Ir/DEZI=;
        b=HuKDTDkXG/mBUCXsSTb88EADBvl9WlgM8/v8MAxSelQf5qeOPw35RmEoocz2dEWOSO
         8KmxQe6wQk7Uk+jYoVWj8lTIMTGY4Qxrsh40BtTUGChZ/8Kvda6ihdX3HDE3Ca+FPSGF
         YCfeMo1jUz1+OlOzuE1eAk/kYqQZVPDKi9KFZt6OI/0piDeYFg3fWFZSjKsy7cUTVfLn
         lwSfI/ineirFP9x8g70jo03O91PNIMKflSmUYfJYow9ovwcNnh5Li7soX28lAnFvFxKR
         +fujXZWpk6nxyBJaIEnTGSHl4VvZU5We0bBSVTQl7z+a7imIh74DeA65icdebaKAHBJ0
         YG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731411253; x=1732016053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p8lUFUH2waVn78UrKgyOw+mGXVmAuWD1Fv7Ir/DEZI=;
        b=ltHx+oM7aXsMtrLPEVhs89/bBV+K8+pbcLGUpdH9Vn+8Ma2QTzAmg+QPcKc8wYd0vL
         iO+0gbuTPZeaou+EkxjwHaaNeFioGQItYRIkOWmg8t9zYixW4193Wixe4jktVBNP0XWE
         46LhfH+SOE4dGg3AaqXSLu3g/H6QZ9FgriNcL9RHuCoBC7fIPmcZXL+i7deM/YeBB627
         //qtknvm4nkm0T6GCWQKN89xGv+usYTeyNpFYzPF/ayG6pL33hY9EKXRaIZtJhAXwhcJ
         9Oze6D/8Qqf/ywIji6xLPoSeF54OFH7MVnIpf6Cl9OxsDct5CBjwI3HMS5Mm7oWrO41X
         B5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXPK9ZV/m7ZJks9uTFCk/LzzxzfZ0SGoVTGwf9jbA3bCCbQhk82m+OpbBdBwl4qtZpuTVpDZYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQZL/CZwAdRfH+CJZM1iak0zxYTlwOdbmAfGJBrBflfyYI9c+
	/i0e77t6YvujUWVGlJ89hK7TK8iXsc91SJvrYwcNX8DmPp24/gzy
X-Google-Smtp-Source: AGHT+IF5xCBuIoc5jEaBS4xXx+VcFo3dxzc8QwtuKmzZj+eDQanw4NretWcw/nmg0T8JoedfVV7l3A==
X-Received: by 2002:a05:6a20:c890:b0:1db:e328:dd13 with SMTP id adf61e73a8af0-1dc2294ae47mr20788388637.11.1731411253044;
        Tue, 12 Nov 2024 03:34:13 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bab1sm11195177b3a.107.2024.11.12.03.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:34:12 -0800 (PST)
Date: Tue, 12 Nov 2024 11:34:05 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, netdev@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
Message-ID: <ZzM9LXjOP64idiKE@fedora>
References: <20241110081953.121682-1-yuyanghuang@google.com>
 <ZzMlvCA4e3YhYTPn@fedora>
 <CADXeF1GKMJgBQEgxnrOFOF=aSD2NqTBm_bQCKat4bmAEm2aK9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADXeF1GKMJgBQEgxnrOFOF=aSD2NqTBm_bQCKat4bmAEm2aK9A@mail.gmail.com>

On Tue, Nov 12, 2024 at 07:10:07PM +0900, Yuyang Huang wrote:
> > Would you mind also update iproute2 for testing?
> 
> Sure, besides updating the ip monitor command, are there any other
> places that need to be updated?

Usually a selftest need to be added for new features. But I don't if this one
needed since the iproute2 hasn't updated.

Thanks
Hangbin

