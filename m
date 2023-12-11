Return-Path: <netdev+bounces-55772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D300380C465
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D801F212B4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6392111C;
	Mon, 11 Dec 2023 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPpnOV53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21CCE
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:22:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0b2752dc6so37027735ad.3
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702286546; x=1702891346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKohCFNCdsaXRchCfw8hU3DzqxTEDNzYha22s0KIoIk=;
        b=QPpnOV53t3qgKcUsN3wuvgTWuWFzzLcWK58wQ1ch7J3dx1ETtKiqEp+CTrvTI4VXQ8
         mUJF+EwEbA5nq9RWGgnE3SuIdx6sXYMXx5jvC0kFpY5TGmED/S/WhRo0PeTk/6DrwujI
         RkDI8fWRarCtZR7KmjgqDUFag72t3mhqAtuhoHkgdK8Snw3YYskny5p2OzRLZVLdGLc/
         wbPNcfu9SPIrW7XiD7121T7Ee23D0D60C8BEEWohNWbPet7L3dD2P34ZK41SoKc3/flm
         7FTdi0yoOpaKh5dTAcnBVwXIfef7WB6iqvncdu49LR3pEzeoazbt1D86fKTL/+8NWiuc
         82pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286546; x=1702891346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKohCFNCdsaXRchCfw8hU3DzqxTEDNzYha22s0KIoIk=;
        b=DpTn+eFUY7CVo+Ovp6TBGY4ddNI4O47+q2NldWZw9Sx8gcZi+fkVUPDHQKjn7j7HOr
         u/yJIOkcNFu09m26s2GE6fI5KgqlgbOBPo7hO8n4sNgx0vgn6NtC1UKKXv5ABDIEdnRO
         ABy4lIIiLglTsXLZ7meR9PSxomeOwm2WOIJpkwzyKfwmGeXWmyv/pxfWjCM4r5h9S9Cn
         uQQPLop8kAItDbc5VmsYTiIStTha193KuB4p4+np14RlWmSyaIw6dxUzm7iR80cbWEDw
         gbtjt8QTd2wd8WiQcH7c85RvB2t2bkPc3iGt/ssfUZa7+WY0hQmnso5WCy2hbKGlCksl
         MzwA==
X-Gm-Message-State: AOJu0YyZ+8/V5TEqPZohuePpzbXJvzx2Dsm+wmqNeBACUap65uvR4IPi
	hX+g6Vb8yCAg+gyc6ZNzJak1rTkWi44QCuhD
X-Google-Smtp-Source: AGHT+IG72P9IBHv39vBgp6Oiq8wvNqlnp6mU5DK187UnVJinaeKx+HBLacEaF7O6H62aRgon1kyV0Q==
X-Received: by 2002:a17:903:2448:b0:1d0:8cb5:49dd with SMTP id l8-20020a170903244800b001d08cb549ddmr4191178pls.69.1702286546220;
        Mon, 11 Dec 2023 01:22:26 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001d0d3795b25sm6129435plq.172.2023.12.11.01.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:22:25 -0800 (PST)
Date: Mon, 11 Dec 2023 17:22:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: selftest fib_nexthop_multiprefix failed due to route mismatch
Message-ID: <ZXbUzpDGErm-JXSC@Laptop-X1>
References: <ZVxQ42hk1dC4qffy@Laptop-X1>
 <01240884-fcc9-46d5-ae98-305151112ebc@kernel.org>
 <ZW_u7VWTpWAuub4L@Laptop-X1>
 <02ef5de4-d57f-4037-8968-d9bf791bd903@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ef5de4-d57f-4037-8968-d9bf791bd903@kernel.org>

On Fri, Dec 08, 2023 at 12:21:55PM -0700, David Ahern wrote:
> > Hi David,
> > 
> > I re-test this on 6.4.0 and it also failed. So this looks like an env issue
> > on your side?
> > 
> > # uname -r
> > 6.4.0
> > # ./fib_nexthop_multiprefix.sh
> > TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
> > TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
> > 
> > And from the test result, it looks we should receive the Packet too big message
> > from r1. So look the current checking is incorrect and the "from ::" checking
> > should be removed.
> > 
> > Please fix me if I missed anything?
> > 
> 
> I ran it in a ubuntu 20.04 VM. Do not recall any specific sysctl
> settings to the VM, but maybe something is different between U20.04 and
> your OS

OK, I got the reason. The "from ::1" is put in rt6_fill_node()
when CONFIG_IPV6_SUBTREES is enabled. I will fix this grep issue
in my next selftests namespace conversion patch set.

Thanks
Hangbin

