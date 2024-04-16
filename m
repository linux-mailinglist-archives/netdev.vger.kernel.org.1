Return-Path: <netdev+bounces-88312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BD88A6A50
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3732823C2
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE912A16C;
	Tue, 16 Apr 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f3wj7fEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53658127B57
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269366; cv=none; b=Pclb1TcT2v/iZ1vLWSg9w6RUI9hMqwMUegUZPzerbsuVdLZ7WdcJtzUlIZFjxPkdls/+JxC4CAI8SW5GHQCxCJLS2lkS1IMYSFyamEoF5Uf+BacNAGZVb6umw2z/bqD8kfltldOFzv2XuXIzbsvmrUmyPNFQsmJBlRTPjGJgOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269366; c=relaxed/simple;
	bh=vfnIhtqIH2GFXfjtE6GFi1v6wMbsVzOlqu4GlPZVrSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBbU0P1FV81qLi7rR1NUzaDO2Yop05cc7aZmmS1y4fTL1TH4z1mv8Z1qd2YUmXGUb3GWqS0oNVrxDa1rU8HKyvFgZZ4ss/HnIFXYrQLUpe8mj1V7XfsYw8+2V/MNBCSfNjy2xw21WaiEqRdWe2mJHaXk/gWGiX6U6YncRIEQSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f3wj7fEO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso4780995e87.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713269361; x=1713874161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oqxPAaSQZjVLJpXWwn1Iq1qW/Cwql7zAxPWUp8yUpDY=;
        b=f3wj7fEOqIJNYERxa7E7Lrgb18FCSJauAOtDBo0ZtHYV+ji5667zgqTPVuUenKRsuZ
         YhJkDVQycKVEusdtEnRazhmSQ7p9lfMiHA9eZEgKVgSFgeZl6IvB4jaCX0mA5ldVqvxo
         gX+gk3x5Ohwcy2XIYLoC/OeRHcGi/rN9+fKvFdhkmBgOFXVOslFX2PdjJmPKPEb3Tomg
         GcyyP5Rtlu1/bLBSvlhgeuo8I9hkApJ3G9L/aBc1wI119FFbET1+a14RK673aZs+jrZz
         3dpKHrbwZF0Pteo9huQDeYuk8zRBgG+Mjaduh1dsZ++HzCS6EtpspKnBKWPw9r7XOj/f
         m39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269361; x=1713874161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqxPAaSQZjVLJpXWwn1Iq1qW/Cwql7zAxPWUp8yUpDY=;
        b=i7r8n7uQOrJm4QUWYndGI+oQ+pL9zyytjk3x8FmyH7JAatw1We4W/s65G5mw66MIkB
         e2B1mVjfxw93/VdFYkNPrIrfmft1M46aALS9BGVdC/+j6YcEH5ZHctHWNCpp04XnEPF/
         jFur/ZuK3Wp6HEqkfARE21j48kk0oR7ZvZNx9Ii5PF+r82zpeLZPBmZBQRAD1PzWCCv0
         MWI74IYnQHW+tl+FzrPb0Tz5bzaCf15xZuMUB0XuegKTOuB0yR0r/oBOFnCHKAvSkYkZ
         e/9QKyyVvSMYAKEKF6vCkEhvryaJc44y8Xf/PYGNAb2nsDozYIdbF64Ojaubdqdkdhg7
         BNzA==
X-Forwarded-Encrypted: i=1; AJvYcCUAx7zXodYGAgFn2svw8Eql5EdRDFHa3LYfBZQcKlhO7eRqloLzLWJM+BD1bTGRMX9nywyqlyxf1tPBfhu2pNFUK6SUgVeo
X-Gm-Message-State: AOJu0Yz8iwBxdXlcHMWs79iewdmY1bpl69IP0LPB+A7vWJBIQ0x/Enh7
	ojEQ9vVKm+dBS6qcW1aDOfmaNUOxfi2MitUumIEFFv6pXRuBIIK66EaJwlnJ12g=
X-Google-Smtp-Source: AGHT+IHT54aMXvJiXFtw1WKEb8p0c+IaZ9qdQXgU5/dE196fUvlVrIATdu0VWzlkVp/piTmXEB4Dzw==
X-Received: by 2002:a05:6512:2303:b0:519:166a:d217 with SMTP id o3-20020a056512230300b00519166ad217mr2411280lfu.32.1713269360991;
        Tue, 16 Apr 2024 05:09:20 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709060ac700b00a521904b548sm6776006ejf.166.2024.04.16.05.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:09:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:09:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: maciej.fijalkowski@intel.com, mateusz.polchlopek@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	jiri@nvidia.com, michal.kubiak@intel.com,
	intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	wojciech.drewek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v3 3/7] ice: add basic devlink
 subfunctions support
Message-ID: <Zh5qbxbOwMXrTnO4@nanopsycho>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-4-michal.swiatkowski@linux.intel.com>
 <Zhje0mQgQTMXwICb@nanopsycho>
 <Zhzny769lYYmLUs0@mev-dev>
 <ZhzvGlDiuaPSEHCX@nanopsycho>
 <Zh4JQ4RDRIAYC+V7@mev-dev>
 <Zh4XsXwDxeu936kw@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh4XsXwDxeu936kw@mev-dev>

Tue, Apr 16, 2024 at 08:16:17AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Tue, Apr 16, 2024 at 07:14:43AM +0200, Michal Swiatkowski wrote:
>> On Mon, Apr 15, 2024 at 11:10:50AM +0200, Jiri Pirko wrote:
>> > Mon, Apr 15, 2024 at 10:39:39AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> > >On Fri, Apr 12, 2024 at 09:12:18AM +0200, Jiri Pirko wrote:
>> > >> Fri, Apr 12, 2024 at 08:30:49AM CEST, michal.swiatkowski@linux.intel.com wrote:
>> > >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> > 
>> > [...]
>> > 
>> > >> >+static int
>> > >> >+ice_devlink_port_fn_state_get(struct devlink_port *port,
>> > >> >+			      enum devlink_port_fn_state *state,
>> > >> >+			      enum devlink_port_fn_opstate *opstate,
>> > >> >+			      struct netlink_ext_ack *extack)
>> > >> >+{
>> > >> >+	struct ice_dynamic_port *dyn_port;
>> > >> >+
>> > >> >+	dyn_port = ice_devlink_port_to_dyn(port);
>> > >> >+
>> > >> >+	if (dyn_port->active) {
>> > >> >+		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
>> > >> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
>> > >> 
>> > >> Interesting. This means that you don't distinguish between admin state
>> > >> and operational state. Meaning, when user does activate, you atomically
>> > >> achive the hw attachment and it is ready to go before activation cmd
>> > >> returns, correct? I'm just making sure I understand the code.
>> > >> 
>> > >
>> > >I am setting the dyn_port->active after the activation heppens, so it is
>> > >true, when active is set it is ready to go.
>> > >
>> > >Do you mean that dyn_port->active should be set even before the activation is
>> > >finished? I mean when user only call devlink to active the port?
>> > 
>> > The devlink instance lock is taken the whole time, isn't it?
>> > 
>> 
>> I don't take PF devlink lock here. Only subfunction devlink lock is
>> taken during the initialization of subfunction.
>>
>
>Did you mean that the devlink lock is taken for DEVLINK_CMD_PORT_SET/GET
>command? In this case, I think so, it is for the whole time of the
>command execution.

Yes.



>
>Sorry I probably missed the point.

Np.

>
>> > >
>> > >> 
>> > >> >+	} else {
>> > >> >+		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
>> > >> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
>> > >> >+	}
>> > >> >+
>> > >> >+	return 0;
>> > >> >+}
>> > >> >+
>> > 
>> > [...]

