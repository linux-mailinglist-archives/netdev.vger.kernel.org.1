Return-Path: <netdev+bounces-87805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E16D8A4B26
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D62CB20A7C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2F83BBF0;
	Mon, 15 Apr 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pFymHNoy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0983BBEF
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172259; cv=none; b=f8JyAtFFkD+VZr30ZzKlqQCvZQbav3rprlouIADUkCp03vj7L3Fm5GOpysGbJjG8YRisFr6YQFFH7dVZ2FWJ4xlWjUlRv5ECUYendtGDxe3tw2MDfMwMfyMS/VASGCSLyutk6MFQT8P4vJwqTeewsCJmzwNhNS1NyEqfcddsEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172259; c=relaxed/simple;
	bh=9us6Y1ajEiiV1jyVFPoncNu5ktaGpKe94wnmRRspazY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msBO3EnRtn86O9cp7rERgbsfQ+XbvMZr8/qbXYIPXE2CrNwtCH7xtM6Mn1IKxTeF9Rw64et/1Lit6JKXbqHFD4V2AtZ19FmB/vcnUV6VIiRYiZmDpatlgEvyqu3ukN5O2zglbDPsz+h7iuRXo3EpBLVWvDSCJ6dAJaUlJOJjvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pFymHNoy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57020ad438fso1502569a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 02:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713172254; x=1713777054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4XjbL6a5/Im8TK1zXqyW0HHwUewiq1K7ne1Tk5toYM=;
        b=pFymHNoyWTr7tg4VwooAxF2MudzZ5VoeEI8WVVuNv6Peiog3VVaCUDy4H1Kx2b1jXd
         R1+UBRwK9S/8xMZP8OdnRnD5Nskeq1JvnnMSNYNRiSebsQJ9ZQvmaFt3TX/emi9tIdzv
         DMZ2zLm+7NtQmx6yIx4P+NmuUy8UzKlfjHiTia9gEy94oIHqUkjNlL/msxzjK6g3Qxva
         lUqfAzYoro1iDyEhhtBnDax8UlOoWHIkdzMnZAjxNtjXNPFP+zCa6g4X21l2eikpBEBs
         BlUhDwV99W+/sZfp0torIUYzvysdVcWzcbPD1Kczr4h4l6LuBCeSVj7AfbkX4dXjJ6m4
         goPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713172254; x=1713777054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4XjbL6a5/Im8TK1zXqyW0HHwUewiq1K7ne1Tk5toYM=;
        b=HwEFk+NBDkc0MW8KVIwc8U87XBWNvY7oujKSLu/jtDEqF95sWT2Ab/rSjC0V0ANMQx
         4VG6DR5hI+868dBJ4YnKSXRNY0u0KGiFXZk36MvzHrHHwj2uP/2uDYxrPd9drSJNh5cK
         qstFT1UBQ19clXYXbbrcKt5bdBRQuA8Yd3TyRZKl/VGRImHIqcfeFxA4e3aIZsMB5abo
         baObrhhX6nC9/NKwgrijEumHNV++RrFZmeck6X62vWrFJOAXlhJCh4gP2dYjxDJNd7vA
         C/9h7S3Jfey+hXckaJt/7MI1kOiD9Z/2e9Sa5gW2XRtjRNP1ao1FdQwHQq33BKOlxccN
         WqFA==
X-Forwarded-Encrypted: i=1; AJvYcCXAdeWcmLTDKWZTt5jJGCY9tzNQ7IjUgMrh8hLgF5BZbGB+IMHwONf9V0ndnv6SDHPjBBUhs9/rzpDLvurC9afpU75n+ZUd
X-Gm-Message-State: AOJu0Yy4Tyhr78jyUl0ZtWoZBj9eYZcE4vwm+7ddyrNANyKuiMZjuX99
	5Tilfv9S/Jq6jdRHqSGYLpLoFdGLi+ZGEVy2RAcETacuKVjOsseaM3HQuvVE5ww=
X-Google-Smtp-Source: AGHT+IFoB0ypaD1UliUU36N22hJtn0BEz8IsHUYPTfllYjwZT6Ka9HjyF/0E/gkjeav1LS85OdOydQ==
X-Received: by 2002:a50:d78c:0:b0:570:392:aa1a with SMTP id w12-20020a50d78c000000b005700392aa1amr6121914edi.7.1713172254337;
        Mon, 15 Apr 2024 02:10:54 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402091200b0057025ea16f2sm1149069edz.39.2024.04.15.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 02:10:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:10:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v3 3/7] ice: add basic devlink subfunctions support
Message-ID: <ZhzvGlDiuaPSEHCX@nanopsycho>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-4-michal.swiatkowski@linux.intel.com>
 <Zhje0mQgQTMXwICb@nanopsycho>
 <Zhzny769lYYmLUs0@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhzny769lYYmLUs0@mev-dev>

Mon, Apr 15, 2024 at 10:39:39AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Fri, Apr 12, 2024 at 09:12:18AM +0200, Jiri Pirko wrote:
>> Fri, Apr 12, 2024 at 08:30:49AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>

[...]

>> >+static int
>> >+ice_devlink_port_fn_state_get(struct devlink_port *port,
>> >+			      enum devlink_port_fn_state *state,
>> >+			      enum devlink_port_fn_opstate *opstate,
>> >+			      struct netlink_ext_ack *extack)
>> >+{
>> >+	struct ice_dynamic_port *dyn_port;
>> >+
>> >+	dyn_port = ice_devlink_port_to_dyn(port);
>> >+
>> >+	if (dyn_port->active) {
>> >+		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
>> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
>> 
>> Interesting. This means that you don't distinguish between admin state
>> and operational state. Meaning, when user does activate, you atomically
>> achive the hw attachment and it is ready to go before activation cmd
>> returns, correct? I'm just making sure I understand the code.
>> 
>
>I am setting the dyn_port->active after the activation heppens, so it is
>true, when active is set it is ready to go.
>
>Do you mean that dyn_port->active should be set even before the activation is
>finished? I mean when user only call devlink to active the port?

The devlink instance lock is taken the whole time, isn't it?

>
>> 
>> >+	} else {
>> >+		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
>> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
>> >+	}
>> >+
>> >+	return 0;
>> >+}
>> >+

[...]

