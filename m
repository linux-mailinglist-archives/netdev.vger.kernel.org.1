Return-Path: <netdev+bounces-147800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA59DBE80
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 02:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4AAB20CE9
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109EC13B7A3;
	Fri, 29 Nov 2024 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXEmgGFN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FD1386DA
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732845557; cv=none; b=qZumpcbY4Tht44x2QX7JwbdiU4b4X3dm6i5NtVSiahNAZT0jVP743MabBfEdsFf6J6EFEskAFl2y2n5Hpc+ulYAfee6Dl0vNmE9gfV6vvTo3WtufrbYdwS77owJOyQqa/TemGt7ConcLJyM/Mi8XesbnkD95JTpjd7DHS8/qKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732845557; c=relaxed/simple;
	bh=lyDDqU5fPmxLyGjsg7dIl4Yau70OmpuEXhcGX7d0GPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE6gTc9e3ErsgIPzZmPEo17McVvD/JUUy2qq5CFEUh/6/PmxdhBIsH9Wh5kCV+BGZxPTw/3rReamsMgQsj9zgp7X7BfGj6pYiYWiNYFWkDX79Tq+62FzbvYGtLdfKRqYwDe6cX7Q3VHiZV+sIUIaVQJa2aylj5I54+NvRSp1gW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXEmgGFN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2124a86f4cbso10116195ad.3
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732845555; x=1733450355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzO6VXHjHdzTlhh2EE5SsrFQEUBPsjVZ9JE0iRQcsK0=;
        b=HXEmgGFNcouoI84MVYEwHniYtaOnqGMj1fCRGpt6z72Wn8Ue6ej+Cv2iI6JjtenRd4
         IPjh6OWsmur5bozAqGPzyI1BXOvrDqaPNCGbYd5jJhIZ6nOKE5xXJnzQ8UYplSraLp56
         Kg3guClHcoXBcUD+7vhBahKRxFLPjLyvzN0RCKI3BTL+Q5zjbaQCf1437nYvRYyh9+Xz
         eIsQOwke+6Oc1KkFYuqboJJ9lX7LuMYOfxUss30BddkekyNJkmYYkbg7GnQ/GIdXpA4T
         mzhA101p/GSCBTkUwtwO/1H5uAzzgEpWqIIx4W2HXt+IENzBkIO4XACvoFBELOrRxMR2
         57bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732845555; x=1733450355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzO6VXHjHdzTlhh2EE5SsrFQEUBPsjVZ9JE0iRQcsK0=;
        b=Tim2fsiFnssy7fMiJYzVjgE2OSG1anOIfpKuQSSvt3JgA7kJzJvJKphvp9h8dvz33d
         5pBopIRL1KsILj8zJfB6FwWHAKji2XQ2y76dk2wR7kBPzq2NVPgIukTCqCMwYb36pxjC
         jYaWZ4HYunYEg481UZ0ClUcmPzjcAP6Qbolv2RrArc3oilacIIrEFe/91yljgX1Q1Xx/
         F+M6kqm/WHeOVLREVC1/RFXOEk6QAjCVCxNmhsOyERL7n8gcBc/dc0siinUVWkJGUsdz
         BprWXqwVScpna5r5eIyBBP+6gy4nWD2JEASCl2TzooMcJyLhSlickgL4l7pAbOOAV+rx
         gdCQ==
X-Gm-Message-State: AOJu0YxyYu45f2qg4gE361IqloQ7S8Z6WOAe9PUkAsG3/ZgouFym7GbF
	hWxwQ5CXVHKxuhwA2UMlGFsl91hQ2erq8/ejqX1GR+Isg4qHrzYL
X-Gm-Gg: ASbGncu6ZLJO7rZ6U3Wt8W+PUrweKxORBxm06U9cyz0sEDJgnJEWZQeeQN4wPPq1lS6
	fRZeTiZko6f56RIf3EM002jXH4+55QaeOPxdjQT0Muc5DszRdGpydDsJsii/i7zfkMV+wcpnznw
	6z4PBxxaJN5euJp3KeiYlu/Yt8MiGlUorZp/ywXvzkZfnmQzCvXNafqD6ChKCBrsxtPswCLGaOG
	+fFl9M8bCrP+bx/qbY4xjlFew+Flu41Zt4vhoFLygktByK24rDOYSfa
X-Google-Smtp-Source: AGHT+IGg8DOI+6IfDQ4t3RQCL08qcbfUr98hEEwUys79Yyr+QV3AuWombuRwlGf2y5LhINap+ZrFQQ==
X-Received: by 2002:a17:903:986:b0:20b:8776:4902 with SMTP id d9443c01a7336-21501b63d3dmr131935355ad.38.1732845554772;
        Thu, 28 Nov 2024 17:59:14 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:7990:ba58:c520:e7e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521983555sm20413895ad.172.2024.11.28.17.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 17:59:14 -0800 (PST)
Date: Thu, 28 Nov 2024 17:59:13 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net,
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Davide Caratti <dcaratti@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: sched: fix erspan_opt settings in cls_flower
Message-ID: <Z0kf8QQjeHjDr6IU@pop-os.localdomain>
References: <1e82b053724375528e82a4f21fe1778c59bb50c0.1732568211.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e82b053724375528e82a4f21fe1778c59bb50c0.1732568211.git.lucien.xin@gmail.com>

On Mon, Nov 25, 2024 at 03:56:51PM -0500, Xin Long wrote:
> When matching erspan_opt in cls_flower, only the (version, dir, hwid)
> fields are relevant. However, in fl_set_erspan_opt() it initializes
> all bits of erspan_opt and its mask to 1. This inadvertently requires
> packets to match not only the (version, dir, hwid) fields but also the
> other fields that are unexpectedly set to 1.

Do you have a test case for this? Please consider adding one (in a
separate patch) to tools/testing/selftests/tc-testing/.

> 
> This patch resolves the issue by ensuring that only the (version, dir,
> hwid) fields are configured in fl_set_erspan_opt(), leaving the other
> fields to 0 in erspan_opt.
> 
> Fixes: 79b1011cb33d ("net: sched: allow flower to match erspan options")
> Reported-by: Shuang Li <shuali@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sched/cls_flower.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index e280c27cb9f9..c89161c5a119 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1369,7 +1369,6 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
>  	int err;
>  
>  	md = (struct erspan_metadata *)&key->enc_opts.data[key->enc_opts.len];
> -	memset(md, 0xff, sizeof(*md));
>  	md->version = 1;
>  
>  	if (!depth)
> @@ -1398,9 +1397,9 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
>  			NL_SET_ERR_MSG(extack, "Missing tunnel key erspan option index");
>  			return -EINVAL;
>  		}
> +		memset(&md->u.index, 0xff, sizeof(md->u.index));
>  		if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX]) {
>  			nla = tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX];
> -			memset(&md->u, 0x00, sizeof(md->u));
>  			md->u.index = nla_get_be32(nla);
>  		}
>  	} else if (md->version == 2) {
> @@ -1409,10 +1408,12 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
>  			NL_SET_ERR_MSG(extack, "Missing tunnel key erspan option dir or hwid");
>  			return -EINVAL;
>  		}
> +		md->u.md2.dir = 1;
>  		if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR]) {
>  			nla = tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR];
>  			md->u.md2.dir = nla_get_u8(nla);
>  		}
> +		set_hwid(&md->u.md2, 0x3f);

I think using 0xff is easier to understand, otherwise we would need to
look into set_hwid() to figure out what 0x3f means. :-/

Thanks!

