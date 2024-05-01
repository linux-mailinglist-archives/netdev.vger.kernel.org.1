Return-Path: <netdev+bounces-92793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E51768B8DB0
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0351F21D50
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F412FF97;
	Wed,  1 May 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlHFERu9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311C12FF93
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579461; cv=none; b=L1bE7OgOs/W2hXz48evDNDpi0I/eR4Kf58bDLwSiXbKwbjYCBP7XtiAhfyp9DG4yE03eQx7cBtr9bHfVyTcv8afsQKsQ8dT9wVM2weMAxMWDi+3Uxpjxzefc1cnKOUreq/C6519HJaHFp40VsX6OOERSvqA5LjqTK9wRiGoXJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579461; c=relaxed/simple;
	bh=P6d5RLZ9VJEKer0SyZETamUjQ9ajSGTTh3YaOmyXPww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl6YuwJ6mcw8JI+XofP21QI93qr1xQgj3FGGc3nM0ujuGdpSvKmCTE+jaGJSB1bFeBHGdbRzt4DROxy4jmMDzxq4cJo4v9l8zI41GnDGC3DgGJYvZ5ZPHYqrxjUsDAY2zzZKQ8h1TfcjWc8Vu1h4Gfy4t0ka3lVtyZQJ4Bai/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlHFERu9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714579458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/YklrOhByKuNoE3Hpyt5F0lLjn7VOok73FuSFdcLv0=;
	b=AlHFERu9a7xvC3A4iF7eRk6ugvVjD5r4LFS44otmp9gCI+q97qy5WGHRh29NcRJ+6evRXL
	CRcmtVz65dAZonaf9ihHP1+thoFBODKRKosRvPkmt4FGKFe0GjY92ZF8mG2oZS6oxi+oF9
	mimWigyTbfP/Wx9vLDbmzIiQJHfMBag=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-0zV1bn1KOo2mW5WVkMk9MA-1; Wed, 01 May 2024 12:04:17 -0400
X-MC-Unique: 0zV1bn1KOo2mW5WVkMk9MA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-572a866721dso467624a12.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 09:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579456; x=1715184256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/YklrOhByKuNoE3Hpyt5F0lLjn7VOok73FuSFdcLv0=;
        b=D6C6ieSQoQJ+R1a191+gD0UJd4jaPit5jQ2NautYaXD/PA1EWQBJmGP5CKFWcsGzZ7
         KSCpQotnpsNr6SshiayoZ3VGrPdcHGOxAi8SYrDqpghdl4o5UghM1rjiKKTkcLxa6GCf
         wI97vm9qRKQrQ9TRMBqJ0cYVC5cm2NDQWo9+I6yNoAKJO6z1FLeljMzzPduFa3qbYBPR
         EihRp19dQni2Oo6tzbUW0AjbIbI9ZfYeJ9od+aiuYaO/hcezRFLbUTs2qnSdpmHxTCAq
         BtMiB3IA6/6qVZlAkTG5Ym8j5voXyABDzAP39XvOrSYpix8fe7Ef9x3oXvdk6m5sHbj4
         PJUw==
X-Forwarded-Encrypted: i=1; AJvYcCWINJKcCzSZN8SzUJyDeYCq9XpiKZeR5/jZYvtn+1lBiULxFURHsoaU2waQ6Xl+dHG6I9jTEhao5VcMoEIbfw5Q4bKdXsqy
X-Gm-Message-State: AOJu0YyTmQT3EgyZIz9Lj7PcJ133/zIrvDPsNGSpyczZ53RWt4BW2rxC
	+mljvfbw7TqyB2QoKDYhzl/1qpvYZaBro0LdaQmbnpZryeguZs5U6AlnyJQC12K35+CbFRp6nzp
	fF0HJ5V8c6FiWwLwnkCNFg/8oVkbSDVLOOCikidOv3czSN3m8wtbIlA==
X-Received: by 2002:a50:cdd3:0:b0:572:78e4:c6bd with SMTP id h19-20020a50cdd3000000b0057278e4c6bdmr1674048edj.27.1714579456059;
        Wed, 01 May 2024 09:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaaihY3p6Ul/xzJhWWgryIS8flkyjApL+P4BpRyfoZzyU2F773yPksS0yIyST2HX5jxGzdFA==
X-Received: by 2002:a50:cdd3:0:b0:572:78e4:c6bd with SMTP id h19-20020a50cdd3000000b0057278e4c6bdmr1674022edj.27.1714579455443;
        Wed, 01 May 2024 09:04:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id et10-20020a056402378a00b005725ffd7305sm5542574edb.75.2024.05.01.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:04:14 -0700 (PDT)
Date: Wed, 1 May 2024 12:04:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240501120023-mutt-send-email-mst@kernel.org>
References: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>
 <20240501001544.1606-1-hdanton@sina.com>
 <20240501075057.1670-1-hdanton@sina.com>
 <6971427a-d3ab-41c8-b34b-be84a594e40b@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6971427a-d3ab-41c8-b34b-be84a594e40b@oracle.com>

On Wed, May 01, 2024 at 10:57:38AM -0500, Mike Christie wrote:
> On 5/1/24 2:50 AM, Hillf Danton wrote:
> > On Wed, 1 May 2024 02:01:20 -0400 Michael S. Tsirkin <mst@redhat.com>
> >>
> >> and then it failed testing.
> >>
> > So did my patch [1] but then the reason was spotted [2,3]
> > 
> > [1] https://lore.kernel.org/lkml/20240430110209.4310-1-hdanton@sina.com/
> > [2] https://lore.kernel.org/lkml/20240430225005.4368-1-hdanton@sina.com/
> > [3] https://lore.kernel.org/lkml/000000000000a7f8470617589ff2@google.com/
> 
> Just to make sure I understand the conclusion.
> 
> Edward's patch that just swaps the order of the calls:
> 
> https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/
> 
> fixes the UAF. I tested the same in my setup. However, when you guys tested it
> with sysbot, it also triggered a softirq/RCU warning.
> 
> The softirq/RCU part of the issue is fixed with this commit:
> 
> https://lore.kernel.org/all/20240427102808.29356-1-qiang.zhang1211@gmail.com/
> 
> commit 1dd1eff161bd55968d3d46bc36def62d71fb4785
> Author: Zqiang <qiang.zhang1211@gmail.com>
> Date:   Sat Apr 27 18:28:08 2024 +0800
> 
>     softirq: Fix suspicious RCU usage in __do_softirq()
> 
> The problem was that I was testing with -next master which has that patch.
> It looks like you guys were testing against bb7a2467e6be which didn't have
> the patch, and so that's why you guys still hit the softirq/RCU issue. Later
> when you added that patch to your patch, it worked with syzbot.
> 
> So is it safe to assume that the softirq/RCU patch above will be upstream
> when the vhost changes go in or is there a tag I need to add to my patches?

Two points:
- I do not want bisect broken. If you depend on this patch either I pick
  it too before your patch, or we defer until 1dd1eff161bd55968d3d46bc36def62d71fb4785
  is merged. You can also ask for that patch to be merged in this cycle.
- Do not assume - pls push somewhere a hash based on vhost that syzbot can test
  and confirm all is well. Thanks!


