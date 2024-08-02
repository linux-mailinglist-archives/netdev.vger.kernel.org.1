Return-Path: <netdev+bounces-115226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B2794584D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4D1B20A4E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C845481AA;
	Fri,  2 Aug 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ra53qVft"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB23F8E4
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722581820; cv=none; b=aecjuuzZOwCnv5358YId77Te79s9iQMwvw+lgYFoAabvf7EKyaax+Pj80GbwOMIwQLstW+IDTwt0o6KHdua+hZf8lH35HRceAUdhd/8IQit4o54bdanqCngEKi3nfnEYkyW5HvFAHWI+lHSueQzTN8AECP75Duqu51rZb1Tz75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722581820; c=relaxed/simple;
	bh=aR7g/tfNGGtKoIYLvredqFIVSuPSpLyaQUXr+xuQbnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arbPpQUfdMQqksqPrjHfWCaY0NulDhZ0jFMtBOnQt3ap5MrdsNxkQRI/chXOx93RaagumowLFafnVCxLQgerT18As9BzZUEAyRmHUIxgnQkU7zhtBBctrI9ZFJmSjLnhzf6XRNEFSOaOiEpx3xVTaCx9clsGV1oPZc1Mzl4uYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ra53qVft; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281c164408so44721595e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722581816; x=1723186616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rm+TjT7jWe8UC4sNWOMrtFaRWseJyNfqObnJtfRcJA=;
        b=ra53qVftX0fR2V+I7olrnt4OvXRB/S3sW8rO7WZExonsA8beAmglrrbIYEzdjZw3xs
         mw+InneUpODfFncJTBCDaSUV2xrPN5YWTV1U4nPZW1wd1Q/inNgkTfNQxM/FM6yGjI2V
         gE8NNHED+iDAbEB6Xdz/Va5id4Pv4FeE5ar8LLBT8fK+nKRj+x64BoYQJTurByFIKYJ2
         FruN5ZDZPC9CnnWBhwDfA3q4PYmzMNjbHgMpmctbTdxvmAjiFYxkIelaidrlROqV7Zup
         pMsOIp9ep9htQQX/PQXvbQcTHhvhc882Q9kE/WLF3535BTgHhcKfxL/yzF+myk/b7bpk
         asMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722581816; x=1723186616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rm+TjT7jWe8UC4sNWOMrtFaRWseJyNfqObnJtfRcJA=;
        b=L9YZhRoiQpA2AivkDI/1A9+sRp194OAsLI9vm7B6B8EarzDdS3ZlhibIHqIu2viL91
         Q5OG6n1PfR/g+vuHyhdj3fKgwmBvaRERGnzsMaAFU8aWFu0yOlvIIpyXE5U58UVSdqmX
         tZsV7ShDgXhC4SF+ds2NYIDvSonQD67hup326dwLI1DNAUZWUJefZec1x7RoQHDShl3I
         4shZyf62lrC2DN+x3jxHYfE0/r+N+HFtK8zDb8K/T7OfbdflbBM6qL/efvMHcqOUNVu8
         7cgzMS25Anh01z3HjkCAoukWamu42qU0YEJ3idsgkIxbCNvVKJDqJ0NmO9Y/cmpTpC47
         Gp6w==
X-Forwarded-Encrypted: i=1; AJvYcCUUcpfhkni0Uz4LXqukvPnwLJUsxKKisLkZLNn/wxCM+Jcv2TXtXXlnBj+6mbX9QSrSI/gvXkbYlnpnAWuXCo2/JXxHFwf8
X-Gm-Message-State: AOJu0YwefnNar9ImHNywV9b9NmVLyUBfApMTQHftx5Z8GJMEltV+4hEn
	ZTJ4UDGDG+uczBOMcqthbS0SGDJhvVrbFZWwhywySB/soee+cpHVCIZQXPYGvqo=
X-Google-Smtp-Source: AGHT+IHbk9ZMZ/aA7u1z3wIro874aVUjI+JjKlyWQ4HiN/Uhxet/M4fBt5V9dIs9BZBzQktLkzsFiA==
X-Received: by 2002:a05:600c:3b16:b0:425:69b7:3361 with SMTP id 5b1f17b1804b1-428e6b2412fmr16682705e9.18.1722581815940;
        Thu, 01 Aug 2024 23:56:55 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cbdbsm1178680f8f.13.2024.08.01.23.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 23:56:55 -0700 (PDT)
Date: Fri, 2 Aug 2024 08:56:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, jiri@nvidia.com, shayd@nvidia.com,
	wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZqyDNU3H4LSgkrqR@nanopsycho.orion>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <ZqucmBWrGM1KWUbX@nanopsycho.orion>
 <ZqxqlP2EQiTY+JFc@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqxqlP2EQiTY+JFc@mev-dev.igk.intel.com>

Fri, Aug 02, 2024 at 07:11:48AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, Aug 01, 2024 at 04:32:56PM +0200, Jiri Pirko wrote:
>> Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
>> >Michal Swiatkowski says:
>> >
>> >Currently ice driver does not allow creating more than one networking
>> >device per physical function. The only way to have more hardware backed
>> >netdev is to use SR-IOV.
>> >
>> >Following patchset adds support for devlink port API. For each new
>> >pcisf type port, driver allocates new VSI, configures all resources
>> >needed, including dynamically MSIX vectors, program rules and registers
>> >new netdev.
>> >
>> >This series supports only one Tx/Rx queue pair per subfunction.
>> >
>> >Example commands:
>> >devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
>> >devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
>> >devlink port function set pci/0000:31:00.1/1 state active
>> >devlink port function del pci/0000:31:00.1/1
>> >
>> >Make the port representor and eswitch code generic to support
>> >subfunction representor type.
>> >
>> >VSI configuration is slightly different between VF and SF. It needs to
>> >be reflected in the code.
>> >---
>> >v2:
>> >- Add more recipients
>> >
>> >v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
>> 
>> I'm confused a bit. This is certainly not v2. I replied to couple
>> versions before. There is no changelog. Hard to track changes :/
>
>You can see all changes here:
>https://lore.kernel.org/netdev/20240606112503.1939759-1-michal.swiatkowski@linux.intel.com/
>
>This is pull request from Tony, no changes between it and version from
>iwl.

Why the changelog can't be here too? It's still the same patchset, isn't
it?

>

