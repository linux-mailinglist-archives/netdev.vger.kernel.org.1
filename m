Return-Path: <netdev+bounces-223500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D823B595D5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E4C1B27719
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E6307AF4;
	Tue, 16 Sep 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="k5xivCmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF03306B15
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024844; cv=none; b=kHIrEgdeJ3kYtasssovukjhuZVOfwFQg+mVfid/1t/dGMfTddSSHPTmgKMG81HhTUb83uaNhbTFEdx3CypNHm237nhW6+w+IeUzsZ5hiSUqruYkzYX2CrLaMIKRtPd3zJtbJjfUWi6Ut6tSQ5Wizk4puKk1BoVcYpMJyqAAnNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024844; c=relaxed/simple;
	bh=cjkrNPcMPrn7Xz2O5IanrnqJQCxQtQkOWRXXc5JOZZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTpHolxTShVtfnFPjs3bM3LMgTEMgHnsdDzGaEe1MtJXDBaG+0h5uvSphX36I72crc1yz3ehzd344+Fe6yvcWq2K1d9TRmaSXLQrLtDQ9E8IiTiG8FbHqB7LonKy82Xef8vPVIR9b6U4oZDFEVIFmx8JI+H/zz/I1lyJ0T9euSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=k5xivCmX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f31adf368so8897125e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1758024841; x=1758629641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF9f665i5VOqFhIxUjK1vRZHiWUJdODBvAOyo/CpsuU=;
        b=k5xivCmXi2L2kJPrCUE7zkf+vvYDFRktHAu3K8NVK9MB0BqfOOMrQDzolwvrKhC5Jf
         YLi2aB3SAPZGlmgmOQc1u6N2RZBqfCt/7rqCo1v6lHV1nbYqAW21MXC8VG0PIMS2DTw0
         bdRO+5VjoOtHGk8059qsjyTfTFkOqPZWnMyML1tZwxTW+KbA+ZbQD5mHIpLncwKmKIWi
         Z/YwmfRXH6kszfZwBAcGC6jiVOfa0kyVzTtzts8JD+wZ5PWp4ezfwk2rAwL7FdvwU4R1
         0bdHZLRjp0jYB6AeSmXbnEZPlIStN0z8b7luLdfqi3z25R8Y6TDPR2/2pPg+Xp4Th2HV
         gPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758024841; x=1758629641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF9f665i5VOqFhIxUjK1vRZHiWUJdODBvAOyo/CpsuU=;
        b=pgJei7NjuG8c5LHfvsOC/rPf5pebUgg+1Vvq28VyPaTSNDa8JSHTZXgzMd25Vz0bJz
         e1owsmArlkk84GbcNlKZQbyrtazLdOxuwtU/wea98JE0g/JDI83KOqQ+FLDZRJ+htOk+
         TZMH9TrJRniIouvx6LCzAWDEDUz9GuZZByytCx+0JxCpvNqYAZeUL6lksovFBT9R+I2I
         6a6025v/bN6SnUAKUPH4jL/sDRIoXMUB7JETiwbD8djshmCAX89lfgDqbop9jJHnfNGh
         qLsEc2QwolWyqTPt/lbn6dLalbtbxSdHagfOkHrIoWPj9hiidCJEHTQpVlm6BZyBeELF
         LtwA==
X-Forwarded-Encrypted: i=1; AJvYcCVplsn/eLmFgAPaPVs7ptUKm7VjhEVl4Tc1eSlomXs10/cWcvv02MQPMhSvToZXbDMyqLdZ97A=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFSVRJBmuufg6PNxENrKQc8AXR2WpTZ1CkpXihFAwLA9Dvx0J
	45kDc2SsVEVtZA1qVVO//E8uLIcNm973+ZCyKx5Up76WLlB3nvfw32xkDmO7X4ifmqA=
X-Gm-Gg: ASbGncsy4WtHRbSei4SBSvfZaYVKlXZVsL1OdfL4X6nZi1fR5rXhn3f8cNSax8sFoTm
	NPuxpDK7TLtZnwFxuzqUvqrG47R9PDi9a1cz5FUCNmYSEJC38Q/plmhHz+5WHSTJFH989tbxXFp
	Jzrkob6aiLCt8eK4TgM0scLrFur+OIsxGXqveLljxSno+K2NvxqfS7GJIMrd0ctlJR3Q+b5srRv
	j4iPMM3BP1RG5TiM7j6xi0uvc4ukWYg8C6mjreJ1uxpmPFd6ta0Wng0o20jXp6Zzr3po0vJhph3
	NrGpciTMoZ4SrotYqnXvHuXmBLGafJFh+BErkTBYa9oupaO8kbCyG6q/82My0/ulpF84qi39moa
	Z1lRjwjCwtAF9G5rDjio1Cpl8
X-Google-Smtp-Source: AGHT+IFTV2DDOatWbyPnRVs2gISj9wRvF75+40aO26WS2GjblmHiB5pJ8t3ljkM39Gi336PDUEg+5A==
X-Received: by 2002:a05:6000:4313:b0:3e4:64b0:a779 with SMTP id ffacd0b85a97d-3e765a0adbcmr14740644f8f.53.1758024840702;
        Tue, 16 Sep 2025 05:14:00 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8b7b6ff8fsm13681048f8f.61.2025.09.16.05.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:14:00 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:13:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "almasrymina@google.com" <almasrymina@google.com>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, "leitao@debian.org" <leitao@debian.org>, 
	"kuniyu@google.com" <kuniyu@google.com>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Message-ID: <psjeuxy3ofoh544u4ag6xcfosb72bsfvfcnfzip3swprn4mzua@2owku2txa5oi>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
 <20250828153157.6b0a975f@kernel.org>
 <SJ2PR11MB8452311927652BEDDAFDE8659B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
 <20250829173414.329d8426@kernel.org>
 <SJ2PR11MB8452D62C5F94C87C6659C5989B03A@SJ2PR11MB8452.namprd11.prod.outlook.com>
 <a20848db-868c-457b-bb6b-9959922a3d56@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a20848db-868c-457b-bb6b-9959922a3d56@redhat.com>

Fri, Sep 05, 2025 at 04:09:52PM +0200, ivecera@redhat.com wrote:
>On 05. 09. 25 1:14 odp., Kubalewski, Arkadiusz wrote:
>> > From: Jakub Kicinski <kuba@kernel.org>
>> > Sent: Saturday, August 30, 2025 2:34 AM
>> > On Fri, 29 Aug 2025 07:49:46 +0000 Kubalewski, Arkadiusz wrote:
>> > > > From: Jakub Kicinski <kuba@kernel.org>
>> > > > Sent: Friday, August 29, 2025 12:32 AM
>> > > > 
>> > > > On Thu, 28 Aug 2025 18:43:45 +0200 Arkadiusz Kubalewski wrote:
>> > > > > Add support for user-space control over network device transmit clock
>> > > > > sources through a new extended netdevice netlink interface.
>> > > > > A network device may support multiple TX clock sources (OCXO, SyncE
>> > > > > reference, external reference clocks) which are critical for
>> > > > > time-sensitive networking applications and synchronization protocols.
>> > > > 
>> > > > how does this relate to the dpll pin in rtnetlink then?
>> > > 
>> > > In general it doesn't directly. However we could see indirect relation
>> > > due to possible DPLL existence in the equation.
>> > > 
>> > > The rtnetlink pin was related to feeding the dpll with the signal,
>> > > here is the other way around, by feeding the phy TX of given interface
>> > > with user selected clock source signal.
>> > > 
>> > > Previously if our E810 EEC products with DPLL, all the ports had their
>> > > phy TX fed with the clock signal generated by DPLL.
>> > > For E830 the user is able to select if the signal is provided from: the
>> > > EEC DPLL(SyncE), provided externally(ext_ref), or OCXO.
>> > > 
>> > > I assume your suggestion to extend rtnetlink instead of netdev-netlink?
>> > 
>> > Yes, for sure, but also I'm a little worried about this new API
>> > duplicating the DPLL, just being more "shallow".
>> > 
>> > What is the "synce" option for example? If I set the Tx clock to SyncE
>> > something is feeding it from another port, presumably selected by FW or
>> > some other tooling?
>> > 
>> 
>> In this particular case the "synce" source could point to a DPLL device of EEC
>> type, and there is a sense to have it together in one API. Like a two pins
>> registered with a netdev, one is input and it would be used for clock recovery,
>> second is output - for tx-clk control - either using the DPLL device produced
>> signal or not. Probably worth to mention this is the case with 'external' DPLL,
>> where ice driver doesn't control a DPLL device but it could use the output as
>> is this 'synce' one doing.
>
>Yes, this simply describes a diagram I described in my DT RFC [1] that
>defines relationship between DPLL device and network card.
>
>		   +-----------+
>		+--|   NIC 1   |<-+
>		|  +-----------+  |
>		|                 |
>		| RxCLK     TxCLK |
>		|                 |
>		|  +-----------+  |
>		+->| channel 1 |--+
>+------+	   |-- DPLL ---|
>| GNSS |---------->| channel 2 |--+
>+------+  RefCLK   +-----------+  |
>				  |
>			    TxCLK |
>				  |
>		   +-----------+  |
>		   |   NIC 2   |<-+
>		   +-----------+
>
>Here we have 2 scenarios... The first (NIC1) is a SyncE one where NIC1
>feeds some DPLL input reference with recovered clock and consumes the
>synchronized signal from the DPLL output pin as Tx clock. In the second
>(NIC2) case the NIC uses some DPLL output pin signal as Tx clock and
>the DPLL is synchronized with some external source.
>
>If I understand well your comment, the RxCLK above is the dpll_pin
>currently present in net_device. The TxCLK for the first case (NIC1)
>should be the dpll_pin you are calling as "synce" source. And TxCLK for
>the second case (NIC2) should be the dpll_pin you are calling "ext-ref".
>Is it correct?
>
>If so there should be another dpll_pin in the net_device let's call it
>tx_dpll_pin... The existing one should be some input pin of some DPLL device
>and the tx_dpll_pin should be some output pin of that device.
>
>A user could set the tx_dpll_pin by ip link command like:
>
># ip link set eth0 txclk <dpll-pin-id>

Makes sense. We have dpll to model this and connection between dpll and
netdev worlds over the pin-link (RX/source). To extend this to add the
other direction seems correct.


>
>[1] https://patchwork.kernel.org/project/netdevbpf/patch/20250815144736.1438060-1-ivecera@redhat.com/
>
>> > Similar on ext-ref, there has to be a DPLL somewhere in the path,
>> > in case reference goes away? We assume user knows what "ext-ref" means,
>> > it's not connected to any info within Linux, DPLL or PTP.
>> > 
>> 
>> Adding control over 'ext-ref' muds up the clean story of above.. The 'ext-ref'
>> source is rather an external pin, which have to be provided with external
>> clock signal, not defined anywhere else, or connected directly to DPLL device.
>> Purely HW/platform dependent. User needs to know the HW connections, the
>> signal to this pin could be produced with external signal generator, same host
>> but a different DPLL device, or simply different host and device. There can be
>> a PLL somewhere between generator and TX PHY but there is no lock status, thus
>> adding new dpll device just to model this seemed an overshot.
>> 
>> Exactly because of nature of 'ext-ref' decided to go with extending the
>> net device itself and made it separated from DPLL subsystem.
>> 
>> Please share your thoughts, right now I see two ways forward:
>> - moving netdev netlink to rt-netlink,
>> - kind of hacking into dpll subsystem with 'ext-ref' and output netdev pin.
>
>You are mentioning above the case where an external DPLL device that is
>not under control of network driver (e.g. DPLL chip on motherboard and
>some LOM NIC). In this case is currently impossible for the NIC driver
>to report dpll_pin used for recovered clock as it does not control the
>DPLL device and all dpll_devices and dpll_pins are registered by the
>different driver.
>
>There could be defined some DT schema for the relations between ethernet
>controller and used DPLL device. Then the system firmware (DT/ACPI...)
>could provide the wiring info (e.g. DPLL pin REF0P is used for recovered
>clock from NIC1 and output pin OUT4P for the Tx clock by NIC1 etc.)
>
>...and also there should be some DPLL API for the drivers that would
>allow to access DPLL devices and pins. E.g. NIC driver reads from its
>fwnode that possible tx-clock pins could be out_pin1, 3, 5 but it needs
>to translate fwnode_handles of these pins to registered DPLL pin IDs.
>
>Thanks,
>Ivan
>

