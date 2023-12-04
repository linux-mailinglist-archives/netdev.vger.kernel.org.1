Return-Path: <netdev+bounces-53536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F1803A09
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4919D280FDE
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D9C2DF93;
	Mon,  4 Dec 2023 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXIdpvYw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCABAC
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:20:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3334a701cbbso948418f8f.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706838; x=1702311638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuAt/2oIcP7atr+tVyhNlqJEF5U/l5T2HdYl2BdmTVA=;
        b=KXIdpvYwXerm6Us3NWYo/XZu5TbGtDWT8pO+Rt0FHR+J2HALLDMaOjt4Xsaovbu0mD
         sjhJZSTk0h3iFqWD3Tb5OIOShFyyz9xfEilPdkl7oBXsbJB+/xxvjQSf9ww/RILmppvI
         4gBGyNggFX4lbwl/dZBbKjYEe7tacBNXkVtWG80H1s6DDfK/R0N9U5eDtymHVsuyYuWx
         zgtv9yiuDKu0fHCj+gBeS2ZZP0oRFPfkLb0fuuNlw7lzuyhwbhlHaKJLDo6msQN8KX1T
         x21dxyNjzml86WAwh4fYPVD4iNtimLqYb8QsG+hQXDpz59kjTgAGzg3Nvg0xTWlG7rKc
         bvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706838; x=1702311638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuAt/2oIcP7atr+tVyhNlqJEF5U/l5T2HdYl2BdmTVA=;
        b=HyrhXqIxpxw90kfMlBmS7xUk5QMb5b6V0SZ95adnU3WZ0i02JXm01yvDgSDU5ZlQBF
         5Ib+y2hJvPSDEf3cPj1ueeESNK+sXT9Hh/HYHJOGBRWI95Nu39l8af/9qiUdXqDMyTrU
         nPHom7X945MjHb5xxBUW65wOWvN/ao94+jytDo9JbMG9/O+qRYu8E0cuXDNqVC5GBEh5
         7CrAxpPGXV8G6ldE8nGdVjnS8d+VWXJLtZH2lkkeaswqDnPWQA3bz35NoLId5aX/6MR7
         Rrl6G1TcNk/DDhfejNvrYbCWTWbw600Ktbxi/KIkxRoN2fwIuciEFiaX4qdQksu2Rx4m
         8wfA==
X-Gm-Message-State: AOJu0YwHgMFIsSUgiL7sjgIBtE9q3+vey9Z7VgQnWk47oTTYpkaYCMJJ
	uZUYJROntcmmSk8TRCzNQvw=
X-Google-Smtp-Source: AGHT+IGrUDUFBWoMu93CQDUzmpoc82hbVMEPrktTmT92gYh2DZJqhn2R+K/LGz0eNC6PLiPNBXc+Mw==
X-Received: by 2002:adf:db50:0:b0:32d:bb4a:525c with SMTP id f16-20020adfdb50000000b0032dbb4a525cmr2339381wrj.14.1701706837846;
        Mon, 04 Dec 2023 08:20:37 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id c12-20020a056000104c00b00333339e5f42sm8895082wrx.32.2023.12.04.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:20:37 -0800 (PST)
Date: Mon, 4 Dec 2023 18:20:35 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: mv88e6xxx: Give each hw stat an ID
Message-ID: <20231204162035.7cjjn6jrbp5lsz63@skbuf>
References: <20231201125812.1052078-1-tobias@waldekranz.com>
 <20231201125812.1052078-1-tobias@waldekranz.com>
 <20231201125812.1052078-3-tobias@waldekranz.com>
 <20231201125812.1052078-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201125812.1052078-3-tobias@waldekranz.com>
 <20231201125812.1052078-3-tobias@waldekranz.com>

On Fri, Dec 01, 2023 at 01:58:10PM +0100, Tobias Waldekranz wrote:
> +#define MV88E6XXX_HW_STAT_MAPPER(_fn)				   \
> +	_fn(in_good_octets,		8, 0x00, STATS_TYPE_BANK0) \
> +	_fn(in_bad_octets,		4, 0x02, STATS_TYPE_BANK0) \
> +	_fn(in_unicast,			4, 0x04, STATS_TYPE_BANK0) \
> +	_fn(in_broadcasts,		4, 0x06, STATS_TYPE_BANK0) \
> +	_fn(in_multicasts,		4, 0x07, STATS_TYPE_BANK0) \
> +	_fn(in_pause,			4, 0x16, STATS_TYPE_BANK0) \
> +	_fn(in_undersize,		4, 0x18, STATS_TYPE_BANK0) \
> +	_fn(in_fragments,		4, 0x19, STATS_TYPE_BANK0) \
> +	_fn(in_oversize,		4, 0x1a, STATS_TYPE_BANK0) \
> +	_fn(in_jabber,			4, 0x1b, STATS_TYPE_BANK0) \
> +	_fn(in_rx_error,		4, 0x1c, STATS_TYPE_BANK0) \
> +	_fn(in_fcs_error,		4, 0x1d, STATS_TYPE_BANK0) \
> +	_fn(out_octets,			8, 0x0e, STATS_TYPE_BANK0) \
> +	_fn(out_unicast,		4, 0x10, STATS_TYPE_BANK0) \
> +	_fn(out_broadcasts,		4, 0x13, STATS_TYPE_BANK0) \
> +	_fn(out_multicasts,		4, 0x12, STATS_TYPE_BANK0) \
> +	_fn(out_pause,			4, 0x15, STATS_TYPE_BANK0) \
> +	_fn(excessive,			4, 0x11, STATS_TYPE_BANK0) \
> +	_fn(collisions,			4, 0x1e, STATS_TYPE_BANK0) \
> +	_fn(deferred,			4, 0x05, STATS_TYPE_BANK0) \
> +	_fn(single,			4, 0x14, STATS_TYPE_BANK0) \
> +	_fn(multiple,			4, 0x17, STATS_TYPE_BANK0) \
> +	_fn(out_fcs_error,		4, 0x03, STATS_TYPE_BANK0) \
> +	_fn(late,			4, 0x1f, STATS_TYPE_BANK0) \
> +	_fn(hist_64bytes,		4, 0x08, STATS_TYPE_BANK0) \
> +	_fn(hist_65_127bytes,		4, 0x09, STATS_TYPE_BANK0) \
> +	_fn(hist_128_255bytes,		4, 0x0a, STATS_TYPE_BANK0) \
> +	_fn(hist_256_511bytes,		4, 0x0b, STATS_TYPE_BANK0) \
> +	_fn(hist_512_1023bytes,		4, 0x0c, STATS_TYPE_BANK0) \
> +	_fn(hist_1024_max_bytes,	4, 0x0d, STATS_TYPE_BANK0) \
> +	_fn(sw_in_discards,		4, 0x10, STATS_TYPE_PORT)  \
> +	_fn(sw_in_filtered,		2, 0x12, STATS_TYPE_PORT)  \
> +	_fn(sw_out_filtered,		2, 0x13, STATS_TYPE_PORT)  \
> +	_fn(in_discards,		4, 0x00, STATS_TYPE_BANK1) \
> +	_fn(in_filtered,		4, 0x01, STATS_TYPE_BANK1) \
> +	_fn(in_accepted,		4, 0x02, STATS_TYPE_BANK1) \
> +	_fn(in_bad_accepted,		4, 0x03, STATS_TYPE_BANK1) \
> +	_fn(in_good_avb_class_a,	4, 0x04, STATS_TYPE_BANK1) \
> +	_fn(in_good_avb_class_b,	4, 0x05, STATS_TYPE_BANK1) \
> +	_fn(in_bad_avb_class_a,		4, 0x06, STATS_TYPE_BANK1) \
> +	_fn(in_bad_avb_class_b,		4, 0x07, STATS_TYPE_BANK1) \
> +	_fn(tcam_counter_0,		4, 0x08, STATS_TYPE_BANK1) \
> +	_fn(tcam_counter_1,		4, 0x09, STATS_TYPE_BANK1) \
> +	_fn(tcam_counter_2,		4, 0x0a, STATS_TYPE_BANK1) \
> +	_fn(tcam_counter_3,		4, 0x0b, STATS_TYPE_BANK1) \
> +	_fn(in_da_unknown,		4, 0x0e, STATS_TYPE_BANK1) \
> +	_fn(in_management,		4, 0x0f, STATS_TYPE_BANK1) \
> +	_fn(out_queue_0,		4, 0x10, STATS_TYPE_BANK1) \
> +	_fn(out_queue_1,		4, 0x11, STATS_TYPE_BANK1) \
> +	_fn(out_queue_2,		4, 0x12, STATS_TYPE_BANK1) \
> +	_fn(out_queue_3,		4, 0x13, STATS_TYPE_BANK1) \
> +	_fn(out_queue_4,		4, 0x14, STATS_TYPE_BANK1) \
> +	_fn(out_queue_5,		4, 0x15, STATS_TYPE_BANK1) \
> +	_fn(out_queue_6,		4, 0x16, STATS_TYPE_BANK1) \
> +	_fn(out_queue_7,		4, 0x17, STATS_TYPE_BANK1) \
> +	_fn(out_cut_through,		4, 0x18, STATS_TYPE_BANK1) \
> +	_fn(out_octets_a,		4, 0x1a, STATS_TYPE_BANK1) \
> +	_fn(out_octets_b,		4, 0x1b, STATS_TYPE_BANK1) \
> +	_fn(out_management,		4, 0x1f, STATS_TYPE_BANK1) \
> +	/*  */
> +
> +#define MV88E6XXX_HW_STAT_ENTRY(_string, _size, _reg, _type) \
> +	{ #_string, _size, _reg, _type },

I think it would look better to take the comma out of this macro and put
it into its callers, so that enums and arrays have the natural separators
between elements.

> +static const struct mv88e6xxx_hw_stat mv88e6xxx_hw_stats[] = {
> +	MV88E6XXX_HW_STAT_MAPPER(MV88E6XXX_HW_STAT_ENTRY)
> +};
> +
> +#define MV88E6XXX_HW_STAT_ENUM(_string, _size, _reg, _type) \
> +	MV88E6XXX_HW_STAT_ID_ ## _string,
> +enum mv88e6xxx_hw_stat_id {
> +	MV88E6XXX_HW_STAT_MAPPER(MV88E6XXX_HW_STAT_ENUM)
> +
> +	MV88E6XXX_HW_STAT_ID_MAX
>  };

