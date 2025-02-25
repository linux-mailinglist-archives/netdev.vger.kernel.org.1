Return-Path: <netdev+bounces-169508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155CBA4440F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9563B2371
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC926A093;
	Tue, 25 Feb 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHfjQWk6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E7267B9D
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496298; cv=none; b=qdWigqyKxbM76C95YwvPsPO8BecZsGcpu6ruAX+YYhO3rY8gdXOZiO0Xf9sEfOVoIkQ0PY8We3RPbelvOI1q/2A10nYuXGz93X9Y4pvmeTafl0C+sxxMgL1JLBKRgLc+MqLXucFw6izopSXAt1ae9iXSCqYn4Bab2qfUkDwds28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496298; c=relaxed/simple;
	bh=0zBCtE/awzflT+NCwE750b+h2oaOYKFXz4Hrmv3M3TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV0cnvJgTMU0+tqnWGwXR468GevJ4/JeF8t4hpHXrosb60K5BeTjSk8rVI5CzXshx3TQEqtxJViiwr9g09bHXUOUCZylmz3D1DFAa+fHYeFAfeu4vXsbeYFH33JmZ159ij0ZcU2cS8qGMV2SEuFeGiHfJyjCrNNb6fXAWIatjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHfjQWk6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740496296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x64f2Cp/XC9f+A9KdRPm5SiYCa/elBQF/ttkPBvsRhE=;
	b=SHfjQWk6AOJs82LVLEgWGfX/iLe5VglHPfG0Jl92cb4wfUN51rA5W6bqx54EuvW+OYtSYN
	N1vburgzj/NvD6n8Jscc/E6X9YEtwjOc40yngg75SKGxsyew2Zfh8Q7qf7WvN8tXSCyO37
	703qVsbOLp69PoAcA1xZbNlkooX5p/U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-CdCPWl8COpCHJoKhE24OUA-1; Tue, 25 Feb 2025 10:11:28 -0500
X-MC-Unique: CdCPWl8COpCHJoKhE24OUA-1
X-Mimecast-MFC-AGG-ID: CdCPWl8COpCHJoKhE24OUA_1740496287
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f255d44acso2508101f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 07:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496287; x=1741101087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x64f2Cp/XC9f+A9KdRPm5SiYCa/elBQF/ttkPBvsRhE=;
        b=rp4ru+mth9Itnf2S7rg/ihFEAkqKI0T7uHu1GJrYYFbgpsVXPVEvSQvSjdzjz4fyPF
         CCBteKAIggJpSI9bb+x1ZSnOLBrmrl5Zn6+LqYMqzFq1bpJrJnlQTyFRLLZBFOPne35t
         t9YWtSzhLd5udAQhvNW+LyVOVnxSwHvharQ8WiV4sQyiLuFLX+g1T+EQjE7F9APyGE4T
         IB9YQ1WE1lZqJMFL/ikMUcxg1zjikH+hhyLJNIrGpukpwhB1uLW9EHqaks3zEHbNT7D/
         YLlnK/qzgVDL4Fcg/1AfkRwZ3/WZ+G/HnrihHHgVyBqhMnpPtWGtnPeMj7E8mrQaznk9
         ox0w==
X-Forwarded-Encrypted: i=1; AJvYcCXeithGRLFs8bLJQcO66IJk2hGyuRKsjqwvT4iMtHMPaU1PkVBdJ4CmCLZKf8wzvdBC+/7FSGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3EMqPUUUfymUxZIATEv6fHXvT47GFO4v90k3RNcfSNkhbQbq
	qYpmTpXGQnmIHcPqzaqUFq/mOkfjtgNcA6i3VDSImk/Y1/rqeyw80cLYl//opO80I4wa6sDU5H8
	hgfbaXn3KNhvxlr6++fi65HSgIBPhyAxJuMAWBbaPLTQit+EMCBi8Gw==
X-Gm-Gg: ASbGncsobXLz9WpAVe6S/Y13GAhbleVLWzVDSSkO/ya84lro6NX+5WNfC2074olxFmG
	wYchhBrO99we6BtZ5zuRvV4cjWbiy//6rg7TkYJN7vLHrI9RACe6akcGNc6+zNocuqtcDSvN02e
	MZEF/bIXJt4zMSmXzOM5pJnxApAQO3f2Ip+kighgYhSgGsWcWc9Q7xb11qTKwxl7i0VY9Qv+UNE
	0+rKcjSlTZepIyD1XutF/l2oJY2Gu+V2SfKhJxXSqRa78KZjKSXQ2pS+Tfzx6sTVB4AhTFDvmlA
	Gc4=
X-Received: by 2002:a5d:5f44:0:b0:38d:cf33:31d6 with SMTP id ffacd0b85a97d-38f6e74f415mr17114047f8f.3.1740496287030;
        Tue, 25 Feb 2025 07:11:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPVK2tbnsLanua7grU4yAmr3WeTHm80ZQWepmsOncyi+lW2bhRCMYQm0JY4RKWrFZExJW+1A==
X-Received: by 2002:a5d:5f44:0:b0:38d:cf33:31d6 with SMTP id ffacd0b85a97d-38f6e74f415mr17114017f8f.3.1740496286659;
        Tue, 25 Feb 2025 07:11:26 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e72c6sm2621460f8f.67.2025.02.25.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:11:26 -0800 (PST)
Date: Tue, 25 Feb 2025 16:11:23 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH net v2 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Message-ID: <Z73dm4P+Ho4EiprQ@debian>
References: <cover.1740129498.git.gnault@redhat.com>
 <5c40747f9c67a54f8ceba9478924a75755c42b07.1740129498.git.gnault@redhat.com>
 <Z7sw1PPY48pkEMxB@shredder>
 <Z7yxN/S1BI4xwy+M@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yxN/S1BI4xwy+M@debian>

On Mon, Feb 24, 2025 at 06:49:43PM +0100, Guillaume Nault wrote:
> On Sun, Feb 23, 2025 at 04:29:40PM +0200, Ido Schimmel wrote:
> > On Fri, Feb 21, 2025 at 10:24:10AM +0100, Guillaume Nault wrote:
> > > GRE devices have their special code for IPv6 link-local address
> > > generation that has been the source of several regressions in the past.
> > > 
> > > Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
> > > IPv6 link-link local address in accordance with the
> > > net.ipv6.conf.<dev>.addr_gen_mode sysctl.
> > > 
> > > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > 
> > There are some helpers from lib.sh that could have been used,
> 
> Yes, I reused a personnal template that predates lib.sh. Given how
> simple is the setup of this selftest, I'm not sure if it's worth
> including lib.sh. But I might consider doing that in v2.

I've finally prefered to keep the script as-is. Reusing lib.sh wouldn't
simplify much, but would require to use bash. And just changing the
shebang to "#! /bin/bash" adds a 1.5 second penalty to the selftest
execution time. That's acceptable of course, but I'm getting a bit
tired of kselftests execution time, so I'd rather not contribute to
increasing it uselessly.

> > but the test is very clean and easy to follow, so:
> > 
> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> > Tested-by: Ido Schimmel <idosch@nvidia.com>
> > 
> > Thanks!
> > 


