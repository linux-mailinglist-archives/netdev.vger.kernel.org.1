Return-Path: <netdev+bounces-145899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B799D1453
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2A71F2157D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA3F1A286D;
	Mon, 18 Nov 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4YKJUpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD419E998
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943314; cv=none; b=oVYiiyqECYNCp5fEDWvfovBhIB02mDD5HN9AZV5Py/0OMbQ9lnkg2K5Rnp8IGHQd+LutlmJMn4QIztK8y8J/YP+9QZOObUt1IBaNaqjKy82oRIA4jECzaasGCTsqwjHD4NsQm4ai4x3HegxNxt/FuEgGjd8X51ZZWmfkLzHQcSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943314; c=relaxed/simple;
	bh=ecCBrTCCE59MkAxr9tXvAPaft2Es9MR1fXYFgUTBxYo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MGP/TudyXMvq+WD+ULFQ+kBRZ8gjlaD9FRGWz/HMaUcGc2buBNKv0ZAcCjGXtKJ7nNvzA0XS6yixKEMjih+lX2YwqeUs0LtkfszgAeCEbjZqp6T/S7jqQaUG2anMNtEmdajoFjFg5w0rzY3y7htG//pCXyu/Qminp14oneBttSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4YKJUpu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46098928354so18153061cf.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731943312; x=1732548112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQA02OfYLKhgvCOp9KiJnfThUN1+EB/HCfiLmzvIGcI=;
        b=D4YKJUpuQ5qypJVwjdOy1/bSYc1vm4eUn4tW/NemkaE56+Q0mgG9cEoLKPiYasTGHR
         0d56JRYUlHofDb8xSY3j273vpRNJLWbFUaabI63brgkKKVceMqjEeHH3qpPZhomdj44A
         0Jy09Qcn6g4RmcdLccZf2qg7M0XTSD56ttCSXCkxDbdNgrCRbU771oCqeMXvKRL+Vmnq
         P24ekAOhf0O3wGOvcQNELKX4m+vypfHiOWapOvUJtmjEBihQIh8Zd2aa+sW6T+OFva/7
         3yz1mPcHBBYPVNN8gN4whK0wuE7MDRgh+YTXc8M8HI7ZL6r5X4j3m7o0GJOuXrsSJHKV
         3UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943312; x=1732548112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OQA02OfYLKhgvCOp9KiJnfThUN1+EB/HCfiLmzvIGcI=;
        b=fEjWbMBf5zHe8fVE899z/e07trwhlM0opVYZUEOboQXtoV+DEU3hVZQ5DD3bv+JzWS
         0Q3iZccVvBtWoYyR5sHb22teM76BZ8FHZcbuuWSJHbML6NLQLDjuBeSH9o/k/OfoalR3
         ZDKj+3b24nS4+Hh7vIh4XsXEJjp4/elpBT9ok0K0krd2tbBMQmO8P59Kutt2JaTPPO8a
         5v21VCrQFgFSdOqNhhx99pr8KraILWLrWngOrzZdLI9NAe0aVZou9Eko6CjOv2V58ng7
         cxZtHHuALXvjsoEMf5+785UVz6QLYa8RD1DV+pYB+VT54zkyFdodvCnemWSZYfuVAxiJ
         deZg==
X-Gm-Message-State: AOJu0YwHaeJZLuMk6g1FEf3F1qKRBQIhArsqWSIc4nMU+xyvp2mGfSCJ
	gXdzscnodbEzEXyECjeNBs36BJdrYy+qP7U67nV4gaIvsIIOJIwz
X-Google-Smtp-Source: AGHT+IHVPZ99rI82oDH7ZVpSYDyjYivWhsouK27JqFUyusTmFkimPE96gARoKps0I+VVO/R7ojCACA==
X-Received: by 2002:a05:6214:3387:b0:6cd:f2ae:5b49 with SMTP id 6a1803df08f44-6d3fb80f9d9mr176121676d6.24.1731943311840;
        Mon, 18 Nov 2024 07:21:51 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dbe066esm36740636d6.13.2024.11.18.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:21:51 -0800 (PST)
Date: Mon, 18 Nov 2024 10:21:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Olech, Milena" <milena.olech@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
Message-ID: <673b5b8ec78aa_1d050f29498@willemb.c.googlers.com.notmuch>
In-Reply-To: <PH7PR11MB5885163CE356FF37F047D1E18E272@PH7PR11MB5885.namprd11.prod.outlook.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-5-milena.olech@intel.com>
 <67365b739f70c_3379ce29452@willemb.c.googlers.com.notmuch>
 <PH7PR11MB5885163CE356FF37F047D1E18E272@PH7PR11MB5885.namprd11.prod.outlook.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 04/10] idpf: negotiate PTP
 capabilies and get PTP clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Olech, Milena wrote:
> On 11/14/2024 9:20 PM, Willem de Bruijn wrote:
> 
> > Milena Olech wrote:
> > > PTP capabilities are negotiated using virtchnl command. Add get
> > > capabilities function, direct access to read the PTP clock time and
> > > direct access to read the cross timestamp - system time and PTP clock
> > > time. Set initial PTP capabilities exposed to the stack.
> > >
> > > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > > Signed-off-by: Milena Olech <milena.olech@intel.com>
> >
> > Tested-by: Willem de Bruijn <willemb@google.com>
> >
> > >  /**
> > >   * struct idpf_ptp - PTP parameters
> > >   * @info: structure defining PTP hardware capabilities
> > >   * @clock: pointer to registered PTP clock device
> > >   * @adapter: back pointer to the adapter
> > > + * @cmd: HW specific command masks
> > > + * @dev_clk_regs: the set of registers to access the device clock
> > > + * @caps: PTP capabilities negotiated with the Control Plane
> > > + * @get_dev_clk_time_access: access type for getting the device clock time
> > > + * @get_cross_tstamp_access: access type for the cross timestamping
> > >   */
> > >  struct idpf_ptp {
> > >  	struct ptp_clock_info info;
> > >  	struct ptp_clock *clock;
> > >  	struct idpf_adapter *adapter;
> > > +	struct idpf_ptp_cmd cmd;
> > > +	struct idpf_ptp_dev_clk_regs dev_clk_regs;
> > > +	u32 caps;
> > > +	enum idpf_ptp_access get_dev_clk_time_access:16;
> > > +	enum idpf_ptp_access get_cross_tstamp_access:16;
> >
> > why are these 16 bit fields, when they are only ternary options?
> 
> Willem, I was trying to avoid holes in the struct and this is the best
> shape I was able to obtain. I'll try to reorder it in v2 and limit the
> 16 bit.

Does it work to reserve the number of bits needed for these enums
and add an explicit padding field for the remainder? Say

    u32 get_dev_clk_time_access:2;
    u32 get_cross_tstamp_access:2;
    u32 reserved:28;

No need to use the explicit enum type with fixed size allocation.
Though using that and/or leaving any padding implicit is fine too.

