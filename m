Return-Path: <netdev+bounces-143400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDD99C2476
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B97F288767
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C16C233D73;
	Fri,  8 Nov 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NekYr+UN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C196233D66
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088289; cv=none; b=DArkTHdYSvSz0kUId/9dLik2WYYSLgjj4RX7nEtQd6B4Fhbf1YiZtIKIZUVxILrYXsRfBQAdm7dd0Op6bsaAzYGsfAsUyFkruvAFyVXE/vvJsVlFYp53LSphI2gIn/0dAy8w58tekHOKqHaXDUSy8wZt5GaCcUCP1DFw4OCnuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088289; c=relaxed/simple;
	bh=/3MgB5TLL0Vh33RO3NR+19Owu0d0NzH9VQD0eANI+co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwcGj0fD2grtEmliGEDr4wa1SI3106A5+fx13q7d534+aJjs5WdhCAcmiXRKHG2ucIEzGVzngtvpAYnHxlbtgCedyFSpYc0yH+9v65++a0CGcXfRXr4dr0IJFFcBp1hzlRraTog/o7sbUO772upr1LIp2LFxTUstgiC0bRgvSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NekYr+UN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720e94d36c8so3228987b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731088287; x=1731693087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pht2Zfqt18dy8oouut94+j6Gl4HetGZZdTUCc/od8bE=;
        b=NekYr+UNjyvSfFRdnSukq6VrJBEyFXr3YCpsQhoqeS302UVszg/eBaBdkUysqOWiXl
         TYWYz9Xwux43PPyE6LZp01HJkNfa2uCA99x2x7H/cTvTphahIdl+c6tDKPNv/ZHlSV3i
         tnDs17AUwiOyx6sLMMXMb3mj6JX+2gNSvmgCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088287; x=1731693087;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pht2Zfqt18dy8oouut94+j6Gl4HetGZZdTUCc/od8bE=;
        b=GLwmsZnfSD0ZF7b8JIm0benp7caAbDUcnYjeyaPbCTIeGl5YlGIugSwqI/OmFr8WY0
         S88oPWOle5gTYkTbmQssbj7MzXXuaIo1LHw0k8uUcBSADQBML9x3X0MmhzjRcxRW8QwZ
         jY18xDzy4OL1ffraA1YOaFQnvLV5JNYUzgD8YlclJeT/iAZISJ6sH4KaVkfsTr64uV78
         UYKyRoAb+t8YFP4myMxj4BsmdeaI0Po0sZxnY9Sjeknd0sOwFCRC+faaGB52lq1LWqRj
         mVpdaYKQq8fuIcQ5/+Sk++WGEp/tTc1HynARu4HH3mocSeml4BNi/gBrNCdh3DLyX9gK
         gc1w==
X-Gm-Message-State: AOJu0Yz1paiZqx0cGT9r9Bj96QHUuE0dYZgBtDBvypImR4UdWAlY0Y5x
	eqAhTT66TQKWnuDFTowzG6T4V7TtPYcEJWVwCyYHeS1+f8yULvLEf8zzrC1pgo0=
X-Google-Smtp-Source: AGHT+IGya6rez+EHBKo0lFA7BET3pZeXAAEZswqdwH3MspfleBVeZZPvdMVfY532zCLASQ5HjtRSzQ==
X-Received: by 2002:a05:6a21:3391:b0:1d3:418a:e42 with SMTP id adf61e73a8af0-1dc23321c26mr5288160637.10.1731088286959;
        Fri, 08 Nov 2024 09:51:26 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407991bc8sm4021561b3a.96.2024.11.08.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:51:26 -0800 (PST)
Date: Fri, 8 Nov 2024 09:51:23 -0800
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v8 5/6] selftests: net: Add busy_poll_test
Message-ID: <Zy5Pmy_m9A1-qoe2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20241108045337.292905-1-jdamato@fastly.com>
 <20241108045337.292905-6-jdamato@fastly.com>
 <672e26ec429be_2a4cd22944c@willemb.c.googlers.com.notmuch>
 <Zy4-GUoYKBo_inRc@LQ3V64L9R2>
 <672e4ea4e979a_2bc2f629490@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672e4ea4e979a_2bc2f629490@willemb.c.googlers.com.notmuch>

On Fri, Nov 08, 2024 at 12:47:16PM -0500, Willem de Bruijn wrote:
> Joe Damato wrote:
> > On Fri, Nov 08, 2024 at 09:57:48AM -0500, Willem de Bruijn wrote:
> > > Joe Damato wrote:
> > > > Add an epoll busy poll test using netdevsim.
> > > > 
> > > > This test is comprised of:
> > > >   - busy_poller (via busy_poller.c)
> > > >   - busy_poll_test.sh which loads netdevsim, sets up network namespaces,
> > > >     and runs busy_poller to receive data and socat to send data.
> > > > 
> > > > The selftest tests two different scenarios:
> > > >   - busy poll (the pre-existing version in the kernel)
> > > >   - busy poll with suspend enabled (what this series adds)
> > > > 
> > > > The data transmit is a 1MiB temporary file generated from /dev/urandom
> > > > and the test is considered passing if the md5sum of the input file to
> > > > socat matches the md5sum of the output file from busy_poller.
> > > 
> > > Nice test.
> > > 
> > > Busy polling does not affect data integrity. Is the goal of this test
> > > mainly to get coverage, maybe observe if the process would stall
> > > indefinitely?
> > 
> > Just to get coverage and make sure data makes it from point A to
> > point B intact despite suspend being enabled.
> > 
> > The last paragraph of the commit message highlights that netdevsim
> > functionality is limited, so the test uses what is available. It can
> > be extended in the future, when netdevsim supports more
> > functionality.
> > 
> > Paolo wanted a test and this is the best test we can provide given
> > the limitations of the testing environment.
> > 
> > > > netdevsim was chosen instead of veth due to netdevsim's support for
> > > > netdev-genl.
> > > > 
> > > > For now, this test uses the functionality that netdevsim provides. In the
> > > > future, perhaps netdevsim can be extended to emulate device IRQs to more
> > > > thoroughly test all pre-existing kernel options (like defer_hard_irqs)
> > > > and suspend.
> > 
> > [...]
> > 
> > The rest of the feedback below seems pretty minor; I don't think
> > it's worth spinning a v9 and re-sending just for this.
> > 
> > If anything this can be handled with a clean up commit in the
> > future.
> 
> FWIW no objections from me.

Thanks.
 
> > Jakub: please let me know if you prefer to see a v9 for this?

