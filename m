Return-Path: <netdev+bounces-72033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C20856455
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01137B2B41E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FF112FB17;
	Thu, 15 Feb 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xdujswnL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D19130ADA
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002697; cv=none; b=P8W0FPVzv6Cp8J8FQpKQrr0hhL93+WkGEGiR56JKkUzgxWYz//3Z1qcfe4VcljOwQ89aqgPHRpHTl5L0G9ni/B0cIie6niO/YxEywwn6QFl6AhmhBizTIR9jusVoF3sp3YArTfxMw8KY+h2ORn2FljiVByiziZdbdpc3Zxr5YEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002697; c=relaxed/simple;
	bh=z8BGyIJsC1E9yFlyhoYQHxDq0nPU1zuRIR3dKZhwtk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLdcR7g4mx8c78RtSKb+uBkU5yLI7yP4Sd2C3g43YO/X0TzhEA/V54ogEss/1Pz6VYg9UxAbcqYEDw751A39ZZQtDGEGnuOkoaysKE2iDJrOKnUHViu1J22CU7M26DZVj0nHv8+sBZ3qrAfPCL1Ie3aRa2hHjhNfiwOIsaG3XwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xdujswnL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso1325282a12.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 05:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708002692; x=1708607492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxMcdT5UzfNcwNKYCePEQr0zb+VpiNLKEPbQ5chnxyQ=;
        b=xdujswnL6Bp6kZCycHZ55avgJFENC/LMZ5wSQVEUqb8LHy1uJtyK+sbt+ixUF16eId
         tlRAXt1Hq0fJ8qtoR5+34zCIsLHlftKgfyhMKYy7QOUMHyaO0V6BVfmmWFP+ceATDKLL
         Vpwy9XkHSaw5EMZfUNhNWqwscWegaGk5I+9QdgieJtczJKnW/CoJVgBrALVSONC0yjcj
         LyhHzr/f1C4yIc389OCOdjI5azvh1426V4nx2emUBxaXn2Nh1+eC5u14DTN1uAAE7inM
         BmZzh8fQJcPezNuNE0hHhBKZu2WoAm4Xk+qK2cROdrWE3PCTXYvqcAyfeyktUpsGBscw
         9k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002692; x=1708607492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxMcdT5UzfNcwNKYCePEQr0zb+VpiNLKEPbQ5chnxyQ=;
        b=igbzTRucVBka/RWmlY51bMyy/pwHB4/eoeytdWEZCpt58sH9AcJt4HxmxmXGZkuHzo
         wvery29TsyZTWgMp5AUs8NH6dsscgBXfraYFJEd5RQs7kQKHTIMMbVlUguVJfBNPngEP
         XsPxC03AQ8p3NL/PeKN+3G+XAnCJ1+5qZkH6rjuxresgqsSSIgkEfRXFdOHkCmDO0zhh
         IJzl1A9qNzXp2HAmzs3YUrOcrLVu4axeNi1SJ+2aUW2A07PtCn1XV9c6wOyK4wOJCB8f
         iFdfLUqX0PZOCziz670UzzNGnKVgeqaiYXKCQ46s4Lllf5wdk4pqTOv1i18tiI35UWOf
         RnzA==
X-Forwarded-Encrypted: i=1; AJvYcCUbwMQ9k3JSGCcVdeoTUcQ7AJLGFuQOQ1vocfnInEjZlJX4bidvqE+q8tHtco3pS1P4waCYuTYBgcUQD4OfRl33/EQrB0dH
X-Gm-Message-State: AOJu0YwFENivTjtPW07m8ddwBBx2oViLU01EbRyhvD74EW/iFI28IWT6
	/86K6aANhhFAEdiPiiblzUBz2WEaDknXhvsj9upq/dnzsVHJ6IqynatyfEiIkzvhPqUIm/yPuS8
	WUJY=
X-Google-Smtp-Source: AGHT+IGO5QH7dTywo2hh+tlhhEkLwPg1ho9P0EcL315UVOtxnkHQfvCeUw7uxCy8ft4BhwK+AnOngw==
X-Received: by 2002:a17:906:4ac5:b0:a3d:7d6b:60c1 with SMTP id u5-20020a1709064ac500b00a3d7d6b60c1mr1154467ejt.61.1708002692443;
        Thu, 15 Feb 2024 05:11:32 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id hd15-20020a170907968f00b00a3d62948fadsm535326ejc.173.2024.02.15.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:11:31 -0800 (PST)
Date: Thu, 15 Feb 2024 14:11:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, shmulik.ladkani@gmail.com
Subject: Re: [PATCH net v2 1/2] net/sched: act_mirred: use the backlog for
 mirred ingress
Message-ID: <Zc4NgKlF_wT5578J@nanopsycho>
References: <20240214033848.981211-1-kuba@kernel.org>
 <Zcx-9HkcmhDR5_r1@nanopsycho>
 <20240214070449.21bc01db@kernel.org>
 <789d5cc3c38b320d61867290115acafb060ca752.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <789d5cc3c38b320d61867290115acafb060ca752.camel@redhat.com>

Thu, Feb 15, 2024 at 01:56:12PM CET, pabeni@redhat.com wrote:
>On Wed, 2024-02-14 at 07:04 -0800, Jakub Kicinski wrote:
>> On Wed, 14 Feb 2024 09:51:00 +0100 Jiri Pirko wrote:
>> > Wed, Feb 14, 2024 at 04:38:47AM CET, kuba@kernel.org wrote:
>> > > The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
>> > > for nested calls to mirred ingress") hangs our testing VMs every 10 or so
>> > > runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
>> > > lockdep.
>> > > 
>> > > In the past there was a concern that the backlog indirection will
>> > > lead to loss of error reporting / less accurate stats. But the current
>> > > workaround does not seem to address the issue.  
>> > 
>> > Okay, so what the patch actually should change to fix this?
>> 
>> Sorry I'm not sure what you're asking.
>> 
>> We can't redirect traffic back to ourselves because we can end up
>> trying to take the socket lock for a socket that is generating
>> the packet.
>> 
>> Or are you asking how we can get the stats from the packet
>> asynchronously? We could build a local async scheme but I'd rather
>> not go there unless someone actually cares about these stats.
>
>I *guess* Jiri is suggesting to expand the commit message describing
>how the fix implemented by this patch works.
>
>@Jiri, feel free to provide the actual correct interpretation :)

Yes, but I was silent not to get beaten by another maintainer for
pointing this out :) But really, the patch desctiption should make it
simpler to understand the code, that's my motivation. Not to bug
people...


>
>Cheers,
>
>Paolo
>

