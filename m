Return-Path: <netdev+bounces-145044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846A9C9322
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13711F22390
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520351A9B4F;
	Thu, 14 Nov 2024 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkr/riLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447518C930
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615608; cv=none; b=AJMHqJumCGu8M6tZC+SoixvEgKrf/A0TqKI9jTzIIqCCymXdZwW3BIYBGmNaJ49nquMcUUKgsMemf2Q8vlHqOgJpPTdjHqIKd8U/fkZni6vDv+88Q8MkYVlYpHRSX676dPyzeHxSIPs4iLua/jN/4eoRLBHvdkVnDJMbRGnTrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615608; c=relaxed/simple;
	bh=dqZsZMEGdn23MYh7HOHJ1WSf0C9QgPyp7Q+z6i7efAM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=d+Frw4Qqla+j4julKw9egd2X5vLOcY3h1N1YZjxhawbMVwoS7046IsKDON0Eh/PjfxYXRFrY7rYkiLGUrcMGADXC3yJ/tvnpU73kkXpWX2gZ+jKXO0dXXxNkdb8G3etnGzN8ib8/TJYQrSAbED8a06RWh0GMfAlatth0c9N1DUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkr/riLO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b13bf566c0so56631785a.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615605; x=1732220405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VvBX0xwkTCxYA1lFX3czPTaYUSHU1LEh4u7qn52MWg=;
        b=lkr/riLOX87am3Z8y/5CckkTKuQMZ8AxdvJ8Hy8wh2sU08jWlVXepLU0DKZsMGfOYl
         Y6pyoGcTRDmH+G5d3cNNFJp/wjqyAHJTPpnT8Eb4Ss681W3O6wFxoVkU+38coYs5TXX0
         vhmuhkYNvQ+d5iLNZZepn1IJvs5cdMpi9uyE3PfpyUYE0rW2+jW0WA4QvySFcFnSTMYy
         57gqfpAjnSPrkJBGonUCQFEB17CMJQ5FGl+EDt417Rfpw2n6yleJOz5iwsVMuSTeegz6
         48z4rvX7YjDVavBqbQ7sm98N9xontjWFPZriFt+qdnsMdEI7cWDQfwodMge0umfSIYKG
         lZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615606; x=1732220406;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3VvBX0xwkTCxYA1lFX3czPTaYUSHU1LEh4u7qn52MWg=;
        b=gc1PR5j5w5FUUzExjiiubLVaGL+PNz5f4oARGwFWddb2uGoq6F+VVR15BO3VmNCtDI
         vhQrHqLw+WjWGwDX1cigmt9T6x1XocDJ0KDDOxdA26RSvhBP7VvKJQDAt6I75iphdaQE
         lPpQsLYzVRjcVgFtEqdCTGu411TnwTJhdOYxKj3jRtF9RnRs7lgWpj3KB+3GTrLkJYWo
         qDpLz7xW3NMtE8spyZA22nHS8ed4WojQbw5CU00+y5oRyxsqyQAcJZZ3huKAdZ/I7Ngw
         6yINXwPLRPWcSlJ9NtCryLIvxTlK6nuBJc4VlLbGkWQ5QZIijaTDMPBya9jE1vsNp9hK
         KS6Q==
X-Gm-Message-State: AOJu0YyK77KDkVzuSLyu04apo5vhUFwy6TfqM5jBA3JgQdlfDQGioUzd
	vldTmB5l6NwkL9NQdz+Gvata7E0NLL03TmMGRUNPIXc8dFfRDGYS
X-Google-Smtp-Source: AGHT+IFoipE09abFSRpmxlpOxmPSWdXjDtYOiwngTuPiUFNdFlV5/0ZO70BbdNlawjqD5gO9m6jpPQ==
X-Received: by 2002:a05:620a:4614:b0:7b1:457f:c88d with SMTP id af79cd13be357-7b362320e8fmr30951585a.49.1731615604759;
        Thu, 14 Nov 2024 12:20:04 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c9ad9a6sm86457485a.69.2024.11.14.12.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:20:03 -0800 (PST)
Date: Thu, 14 Nov 2024 15:20:03 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <67365b739f70c_3379ce29452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-5-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-5-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 04/10] idpf: negotiate PTP capabilies and get PTP
 clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> PTP capabilities are negotiated using virtchnl command. Add get
> capabilities function, direct access to read the PTP clock time and
> direct access to read the cross timestamp - system time and PTP clock
> time. Set initial PTP capabilities exposed to the stack.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Tested-by: Willem de Bruijn <willemb@google.com>

>  /**
>   * struct idpf_ptp - PTP parameters
>   * @info: structure defining PTP hardware capabilities
>   * @clock: pointer to registered PTP clock device
>   * @adapter: back pointer to the adapter
> + * @cmd: HW specific command masks
> + * @dev_clk_regs: the set of registers to access the device clock
> + * @caps: PTP capabilities negotiated with the Control Plane
> + * @get_dev_clk_time_access: access type for getting the device clock time
> + * @get_cross_tstamp_access: access type for the cross timestamping
>   */
>  struct idpf_ptp {
>  	struct ptp_clock_info info;
>  	struct ptp_clock *clock;
>  	struct idpf_adapter *adapter;
> +	struct idpf_ptp_cmd cmd;
> +	struct idpf_ptp_dev_clk_regs dev_clk_regs;
> +	u32 caps;
> +	enum idpf_ptp_access get_dev_clk_time_access:16;
> +	enum idpf_ptp_access get_cross_tstamp_access:16;

why are these 16 bit fields, when they are only ternary options?

