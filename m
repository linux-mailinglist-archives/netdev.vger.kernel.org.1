Return-Path: <netdev+bounces-115003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692E7944E19
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239F7282B14
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169271A3BC7;
	Thu,  1 Aug 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EFsTjxXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25395A31
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522782; cv=none; b=rA7h0+tBjGUPXGdEwAXVnQ3QnqprnfjNU+8r20ngKSSclIglNAZ5Iy0uv1NJLFD4RpYKklyQ0Cc7Dbtq5m1EyFVOe7sLNi/mh7xN3yuT9bli+Y48EKILO6NjjredIfpwMGOEsB+ZA//59I78Ij0uS3Ft7nrjHWqXOGefNlOjo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522782; c=relaxed/simple;
	bh=641XuHTBcnSdQdlhGH/zyKU8VhKyn4FgTbHk1Bx4HQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2tA3R8VjUowYQvAqmSo/Nc+3Tgyrsa/4i4t9H+Av8AUDd6ouYsF4cIrf3xi+4+q+BD5WLKL86Uwy/yzWjVo8jZ2P20dUQeHkWxYfCh7Wuqf8y3XATYxq46/dTOsY3H/aRfVBcFiiAr772XJcddupA3QwM3j9gPVNP1ZPltCl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EFsTjxXd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36ba3b06186so832145f8f.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722522778; x=1723127578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=641XuHTBcnSdQdlhGH/zyKU8VhKyn4FgTbHk1Bx4HQs=;
        b=EFsTjxXdLz+o2fXnJUu30HDFRNmhI65kpj23CVioieCwycXqyEv0lyM6TZC2J6OTZo
         kblfbLI/7e/f8KtMD5gF464WYgVg8ms/+/dTwR8p+YFyHZL4hmTNIuEEX/UGMGy1mt0m
         JfXl9XKNCgT3mit8GrdER708zCUkkEruOFof3NKl0F15mNaR6q8d2wCnQX6XZgZ++fVj
         HCY6lH66Lnbh09raSESPTXNEzuoYzN0SQCq4rx1vIiwA4kboOLvlrsEGbaYBgMlvSKWe
         HoXnz0VZA0i0SQ4dh4j1lhKhyNuEZwB7ylCztQD2BQsLbYmPoFN62REzXwvquKB1ZCDq
         yrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522778; x=1723127578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=641XuHTBcnSdQdlhGH/zyKU8VhKyn4FgTbHk1Bx4HQs=;
        b=kvb9iAJ1f8WOdCWqs03a2qImjcFb7+kaeoMfW7ufZZ/+lI+0Rcz+EKw/WLP13dCRJE
         plJVLNk+LCWgdjVN8xJyJGTZnQeP2rmV5qJ/BlEPdgUIN6gfaOWCfP0Cd9zlM4vRxf5X
         yv9vNGX9hzNe6UIMsYFDyb/mlLZqP6oa4Hr9c+w9yhy3NWSzYix560vq1SHJOmvpYnCu
         3EsuS1m5hOmn3bSQq/uZGKVDUxDkwBZSGCuBTao7a+KMBjH5jKhUfx2XGWm8Q8qtx2ZD
         SIrKXdRo5HIFt+Gp+ktH4uA0SQ7tu0bW0a/kKNzXwLA7sPAqP4NeiLKZx9OVn+BCBCHW
         eAoA==
X-Forwarded-Encrypted: i=1; AJvYcCX6nMKhkHIok7Vg5EH6d1n0J3nL6okJn10v2zOhsC/SkRTCF/tYkUOPqA8EQiULdFFiibBRSd9YbjyN+gQwpHn9fSQJqT1S
X-Gm-Message-State: AOJu0YxWci6GdtyP9QkHS1oWpEJ0K/5WSheGdsxFhyAmNKMpzEZ5tt50
	zFN074tzh5p7To9UG/XOzMGTcar3I4HS+WvoZzYxMhG+T4X/oIJY0hTlVLxMiqA=
X-Google-Smtp-Source: AGHT+IFkOajnFbFwLc6R79VhECOJYn++8Uy/dwIM+N2N+yDuaSozHJT4JFEpppxcLNCt7v2btTe6IQ==
X-Received: by 2002:a05:6000:c08:b0:367:4d9d:56a5 with SMTP id ffacd0b85a97d-36bbc1bcbdfmr7606f8f.44.1722522778150;
        Thu, 01 Aug 2024 07:32:58 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c02casm19647952f8f.15.2024.08.01.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:32:57 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:32:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZqucmBWrGM1KWUbX@nanopsycho.orion>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731221028.965449-1-anthony.l.nguyen@intel.com>

Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
>Michal Swiatkowski says:
>
>Currently ice driver does not allow creating more than one networking
>device per physical function. The only way to have more hardware backed
>netdev is to use SR-IOV.
>
>Following patchset adds support for devlink port API. For each new
>pcisf type port, driver allocates new VSI, configures all resources
>needed, including dynamically MSIX vectors, program rules and registers
>new netdev.
>
>This series supports only one Tx/Rx queue pair per subfunction.
>
>Example commands:
>devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
>devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
>devlink port function set pci/0000:31:00.1/1 state active
>devlink port function del pci/0000:31:00.1/1
>
>Make the port representor and eswitch code generic to support
>subfunction representor type.
>
>VSI configuration is slightly different between VF and SF. It needs to
>be reflected in the code.
>---
>v2:
>- Add more recipients
>
>v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/

I'm confused a bit. This is certainly not v2. I replied to couple
versions before. There is no changelog. Hard to track changes :/

