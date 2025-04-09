Return-Path: <netdev+bounces-180881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB1A82CBC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C530F19E1FA0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3014267F5F;
	Wed,  9 Apr 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkH9AA7L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715025E838
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217075; cv=none; b=N8RB2jhNkgFlSAFl1QC7EmPy9PqPN2pOLquepNcdCorVq73FmBu2t34CmkPPchSP7iYue6X+k493VxylbnHDxtolNEGDwxCAq2GHMQctlEv7hCVU5fgh+QUHKaUXVJrB4HZtiti+6+7WudnWUi/wcRNOyRC7+v7XhrJNVSP5B0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217075; c=relaxed/simple;
	bh=ufuEIUYpvgfeGyL/vQ6RL27Oy1EXMpySdtCHogeFy/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjI0rFzPzu6d1mwITcJ8VW69yr46N1vUP5PthwVNsh/WwW10epg5pe1PjqeqiUKRl6o+hyyPcS/s//gJlDmR9CBK+IlF2hlOCRV+aPi7lvBiVN6sjeoWdP/y9vCwheFu/1lDzVqWARD3beYR6KYVz2zPnIzvrY8YpxqNj9uKzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkH9AA7L; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-aee79a0f192so4583173a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744217073; x=1744821873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nmgyju0Y8EPdNCeE8Zlze22WF3Tal7rq8UHBgP9yGC0=;
        b=TkH9AA7LX+S7DvQxHAThfNitRKX+s196ubg3ehZHcXrW0Th/qyt1NeF9fyYm5/I1Av
         93zCXFfOS4hgguzNO4om7Pzq6KQAAs2TJZ4NhIRqzxnOBYDZElScEKUTuyU2onI1fcaV
         RuHzawTjyIE5A/WFHymv9zvpnSW4X5TLYpGvRXJ5BajWg9QukWEm0FtyTxpZG4QmMA/0
         97MEjMm7RPPO/CFFIEvEx9GJ6c04tFMQRyuTKvVx814pF3b9K4m2TQamld42EpNCWtcu
         H/s9pVgcPURfvu09snoMRMcd6vadAFVITHXe9wW7l6M2ehRkvfD7c5REWjQCbcRvW7MH
         RkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744217073; x=1744821873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmgyju0Y8EPdNCeE8Zlze22WF3Tal7rq8UHBgP9yGC0=;
        b=S3ye4JTIFOxoXPUzsNT2DYbiwmh5dnMvLgJ3SbFkqP3H81r4pE+UR2h2MJ68kiwL7e
         r59K3B9e4yAyOqQw39GXF11r05J83K6pjaHvq/mjGKa6NMJqtR0WEaJ9DMzPacaWsfHX
         D7MGN1P6b01SWeZZ5a54UECtRz0oP6x6DOWmhg2UXKWsEoOP3i9Sk2dOREo+A2PsUMAY
         KNKoPLuahmfQhCWsySxrEh7j7FYC9/PlN+drUrmFn98J5pmIq/MeYZCLFPMxibdWgZal
         L/Ky3tcEiIVda3IdXly7AOYhhOohuXMwL+w/3V6pWiDkKEVQLct9YnQNm2x0rmiAv0sQ
         tW/g==
X-Forwarded-Encrypted: i=1; AJvYcCW6vVnJU1qfJYxK7nTY1yE3gSk94o/qhP+fTxLXquCQnNVYl0YVnasGPhRYuKOsN9aeImPCHsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMIvWTmB+JopI4TJ02Wn8dLcfHAs9xZMqJ+ds9A2PJodXzPw0
	HMqI0NQwO2UrZuCZkdgP98OOCaqQlveCHdonIHsp7FcpSEAfbddF
X-Gm-Gg: ASbGncuJQYIWv3FW+NXjje9hff+Jy8bmluIP8tqqwR1B9u01SSHTqXQzPKd45JUCi48
	fIebrRiMZ9HNu6qpNpM07v52gXii/jlsJC55IX9OXXkQNkuCB7BfEcOvzey6hDypQi/tXz08HvV
	GJrhMjVA3sxcYN5MNOCIa19FoRIzQRX8wiDMSBhmwwLZvupXlaTk7mZNBQsVIb6fD/ogLj8bDHA
	Nyedqs9n0XbQUTczkwuI6BL6qeejPqzFaLf6SIifaGYldnb+QytopqjH+xuSE9z7UTkDyWiJ3xP
	7wN6IWpzj51afZqUMdyqZKm7LgEXV2FTjIjg2fc3FBT9
X-Google-Smtp-Source: AGHT+IHLNqj5665zpEv527ETh62qTr/g2cEka/ihtPW+oR42NUTqOn3kWQ6lOkDffR4lWfwHwV2ivQ==
X-Received: by 2002:a17:90b:2750:b0:2ff:5a9d:937f with SMTP id 98e67ed59e1d1-306dbc0ebebmr5996721a91.24.1744217073566;
        Wed, 09 Apr 2025 09:44:33 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb5376sm14267295ad.186.2025.04.09.09.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:44:32 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:44:32 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tc: Return an error if filters try to attach
 too many actions
Message-ID: <Z/aj8D1TRQBC7QtU@pop-os.localdomain>
References: <20250409145523.164506-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409145523.164506-1-toke@redhat.com>

On Wed, Apr 09, 2025 at 04:55:23PM +0200, Toke Høiland-Jørgensen wrote:
> While developing the fix for the buffer sizing issue in [0], I noticed
> that the kernel will happily accept a long list of actions for a filter,
> and then just silently truncate that list down to a maximum of 32
> actions.
> 
> That seems less than ideal, so this patch changes the action parsing to
> return an error message and refuse to create the filter in this case.
> This results in an error like:
> 
>  # ip link add type veth
>  # tc qdisc replace dev veth0 root handle 1: fq_codel
>  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $(seq 33); do echo action pedit munge ip dport set 22; done)
> Error: Only 32 actions supported per filter.
> We have an error talking to the kernel
> 
> Instead of just creating a filter with 32 actions and dropping the last
> one.
> 
> This is obviously a change in UAPI. But seeing as creating more than 32
> filters has never actually *worked*, it seems that returning an explicit
> error is better, and any use cases that get broken by this were already
> broken just in more subtle ways.
> 
> [0] https://lore.kernel.org/r/20250407105542.16601-1-toke@redhat.com
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  net/sched/act_api.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 839790043256..057e20cef375 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1461,17 +1461,29 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
>  		    struct netlink_ext_ack *extack)
>  {
>  	struct tc_action_ops *ops[TCA_ACT_MAX_PRIO] = {};
> -	struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
> +	struct nlattr *tb[TCA_ACT_MAX_PRIO + 2];
>  	struct tc_action *act;
>  	size_t sz = 0;
>  	int err;
>  	int i;
>  
> -	err = nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO, nla, NULL,
> +	err = nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO + 1, nla, NULL,
>  					  extack);
>  	if (err < 0)
>  		return err;
>  
> +	/* The nested attributes are parsed as types, but they are really an
> +	 * array of actions. So we parse one more than we can handle, and return
> +	 * an error if the last one is set (as that indicates that the request
> +	 * contained more than the maximum number of actions).
> +	 */
> +	if (tb[TCA_ACT_MAX_PRIO + 1]) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "Only %d actions supported per filter",
> +				   TCA_ACT_MAX_PRIO);
> +		return -EINVAL;

I wonder ENOSPC is a better errno than EINVAL here?

Thanks.

