Return-Path: <netdev+bounces-88251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D828A677E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2689D1C20A90
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C8586270;
	Tue, 16 Apr 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oc69htZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9C127B50
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261221; cv=none; b=dBYtdQ+QeSUalo9BQVnOSXuKgvibfMRPJR1i2P3x26YTQClV5Ubp8MrN+yMUXtJPBFGD6y3E4PKAMEsdOjyA7NPPSM8Xd1UQ5X2rkOE31tl6mtH3sq1LbfgZIxa11h0gck6Deu/+T/t7G3a05EOq61cJe4HhBL8TBoqzflY6aJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261221; c=relaxed/simple;
	bh=iIEonw6NbxRylvPksI0bLcfKTL65JpeWOssN5KniBYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8RUl1wTqY2AGKCjuy+MMj8Qm97xoQbIUGK7GNnl0gTBleb3a0X2pa3ZddBfyQyuRm/eWq/zDfYo8X2mdxkfXXtkSVEdrdbh1PpBl7TAqW69Tzr0o2w2Ojdc/w3cbD/JFbsPYnTNEdhlk+ilxvzJk9H2ZWSuNmTXhHDZ+50KhTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oc69htZf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4102025a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713261219; x=1713866019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyOljcBoxRZtBlXPwq1twMKjVMaHbywxijMJdFOzxMA=;
        b=oc69htZfD20sFbRH/7zAgNePCzMTmvYMEvKWjbnmfiP7kU44tkOi3gVgsgkgFsUx16
         r71r1XqknPbknXf3Wc7DkU7TnSSQuH5PlXlDpSTkLflQS4ddVu8Co2XCLZwGRx/YxUZC
         Z402CcHv7tNY6sdhVUv0/BSMMlAWwB2McONReWC/HYBJSbXXWcRZVOE0a4ooWERz+wu/
         zfxFDWhQZHCpwFT/QkssLxj6WAK012Zm3WNkQkM19N1taX8B9B9+eEUaVcS+zJ3TsugL
         h8prO50YZD8utH5Nk3GJrpqg90c+ZDuUHRg5Qs/znULnFgYE/MYJZu0bDphz5bRYQf8H
         ywtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261219; x=1713866019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyOljcBoxRZtBlXPwq1twMKjVMaHbywxijMJdFOzxMA=;
        b=j+P2kje+Jc5RgUl8NHd7TEfYRa064Paj7mpKRRr2tRT9vVA9F0VYmSS2OKn7Rj1gjx
         T/eFZj/lOza5so+yfZnDnJ+pKNZG3nJLTOEODURJOorn1cjuDHF2XFCmw8zYq40hrsyQ
         bMo++5G2hpWEtzky1Eq4tajpZlY2rYXQJ1e+tLt6JkZLfKH8gXamS8YKrjYQheaqc2N0
         KAryZew1DdsXhub5z/jSXatt1A4fRA1XXBcB11RZXsEDkcGp9OYenVTtFG2MLbKOD0Mm
         qtXS7XuVsxAFEEAP268k/i3kj7pCxekv9s0zDKL+xLr1dE2g1RefZ79dA8l4nyREYy+D
         T+7g==
X-Gm-Message-State: AOJu0YyqxnAU6syeecHfYdNfz5DhgyalyuFzopBhmMFtxdvL3IeJ9UQi
	TH8zywSOvFTtGQGzoyqMLpT6+c+rL+7OmjBrelt7jPnC5GyxaHADd70RU1BW0jk=
X-Google-Smtp-Source: AGHT+IGPXttzg9aeuCAj6911eurDwuoGohgiWyCghHh4Uj9hzK08/0+nOrj6kSaE/gRrPbhckX7Srw==
X-Received: by 2002:a50:cd5b:0:b0:56e:d9e:f4d3 with SMTP id d27-20020a50cd5b000000b0056e0d9ef4d3mr10605693edj.18.1713261218408;
        Tue, 16 Apr 2024 02:53:38 -0700 (PDT)
Received: from localhost (37-48-42-173.nat.epc.tmcz.cz. [37.48.42.173])
        by smtp.gmail.com with ESMTPSA id ew14-20020a056402538e00b0056fe8f3eec6sm5678489edb.62.2024.04.16.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:53:37 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:53:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, parav@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 0/6] selftests: virtio_net: introduce initial
 testing infrastructure
Message-ID: <Zh5Kn5OnDdzgB6Rm@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412180428.35b83923@kernel.org>
 <ZhqHadH3G5kfGO8H@nanopsycho>
 <20240415102659.7f72ae8d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415102659.7f72ae8d@kernel.org>

Mon, Apr 15, 2024 at 07:26:59PM CEST, kuba@kernel.org wrote:
>On Sat, 13 Apr 2024 15:23:53 +0200 Jiri Pirko wrote:
>> That is a goal. Currently I do it with:
>> vng --qemu-opts="-nic tap,id=nd0,ifname=xtap0,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:57 -nic tap,id=nd1,ifname=xtap1,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:58"
>> 
>> and setting loop manually with tc-matchall-mirred
>> 
>> Implementing virtio loop instantiation in vng is on the todo list for
>> this.
>
>Just to be clear - I think the loop configuration is better off outside
>vng. It may need SUID and such. We just need to make vng spawn the two
>interfaces with a less verbose syntax. --network-count 2 ?

Well, you ask vng for network device by:
--net=user/bridge

Currently putting the option multiple times is ignored, but I don't see
why that can't work.

Regarding the loop configuration, I would like to make this as
convenient for the user as possible, I was thinking about something like
--net=loop which would create the tc-based loop.

How to do this without root, I'm not sure. Perhaps something similar
like qemu-bridge-helper could be used.

