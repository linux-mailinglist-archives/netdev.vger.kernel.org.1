Return-Path: <netdev+bounces-87734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5C8A44F1
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 21:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C212813D6
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 19:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0103F13666D;
	Sun, 14 Apr 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIU+u183"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013C136673
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713123171; cv=none; b=p40mJsk1wRB2l+kVU5bXijFh6CnpivAgfytrq9iZ45lDWXtxEP58Vw0cFgSesQeTS19hDxDkjPJmZcr0OvXvhEw/nov8XYQpPueDgMoAjCbANm/4+EkvGo5Mwq05aJKyDQ/6+xR0XOndTBXTTdzGSEJO/7b/DwQ7F7oglfMzNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713123171; c=relaxed/simple;
	bh=ZBDhr9CObo0gMu6LfQrcFEjO4OPJIORN3szFKgodQ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvcqKgKL4DljvKJzJWCT64Rh7OcEWKPhrJc3TSrsc55sVVjXSKV0m+ykCFbCHAjjVikqsXAwxcfLCtci3iPWXEkb/CmPfrFhF8zSAOKD0WBC0G1HhFn6j7IlMg8ulmQAHghWxh1gslqEGOojeUOKFWpIWFSDui2nJ8xz6ZNJn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIU+u183; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78ee82e7062so15681985a.3
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713123169; x=1713727969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shhtOSZZ/L6/ysJnfcz7x/2mu05qd++QoRUPCCEdCz0=;
        b=dIU+u183tXDtpCldL388hg4A8J626oUkXlfkL+EoXt0JX78/ez0bLWNCJBxL4U90rd
         +6xo0B3ktM14jznCQZkdVSPSQyxNs2+kuos8WaXxZzOlC0qhrqDvVO25z7Vf0W/UmpBw
         oNp7B3+gg5DVxFiScsa66cnV4DmkjAV7pTyiMuBNJWVja7qf4lSHgIcTmkZt+oqSzLtT
         7H9eMxe2Hy4LjlFqftM0cCyS8B60opmCR4xr7ZdFbO2PdyUSWX7xzkzPLU870zMxB6ae
         JYwEmCEUc1mGrv43yUV7jhYJIX/0rtW61GUUy05o7dWhrycUViQ3MMvUzSK/5TD2rOyZ
         sxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713123169; x=1713727969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shhtOSZZ/L6/ysJnfcz7x/2mu05qd++QoRUPCCEdCz0=;
        b=DQawncKn9gZ0bR6BGkUugy7WbOzwEd1I8kffJvGEX//RgIPgTWbJPHfmXrCMlFwtFO
         GhQub3M+p9zQiEq190q/d8sYEDOxza7FSIW6epi5HFbtT/0JGjnbLlqM7nCFEdWL2Wcg
         vdtXFjVKVolYMhu7YJd/pRDwmh7dZxG4PDfftt09gJ9VM/d93lxXsYEZHpPOkAF7+ofz
         +G80C0fqFU8zwHInT/unmchm6dVs8WjY3zRn9QJ4cmErJ3mQHiHGMYpH0CCUwXQPFzJi
         MukPKiRzgGIJiQM0OFKBZS7FVwAkq/X3NpFV/dgj4rvZBZbZr0iFAZgd8bpUusD1QFdf
         vskQ==
X-Gm-Message-State: AOJu0YzAvoLb1tD+u85OJtm4aKXAgQV2QH09J3gEo3jp2E8AKzpMMYbx
	6yvZax7kekTOS+Ss6Ul6CAqA7DRWdhxdqktP2UoyvGexzANU+cdy
X-Google-Smtp-Source: AGHT+IE18qilwhT3qTku0Jo4p/dnCWrWErx3xvR9CEaq3Z9a6mLLdjMTQJeYdFl80JLzSa8uzEK/UQ==
X-Received: by 2002:a05:620a:88f:b0:78e:9136:1063 with SMTP id b15-20020a05620a088f00b0078e91361063mr9033701qka.59.1713123169241;
        Sun, 14 Apr 2024 12:32:49 -0700 (PDT)
Received: from localhost ([2001:18c0:22:6700:503f:95a9:a73f:4ee8])
        by smtp.gmail.com with ESMTPSA id z14-20020a05620a100e00b0078d60595ff8sm5313822qkj.59.2024.04.14.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 12:32:48 -0700 (PDT)
Date: Sun, 14 Apr 2024 15:32:46 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZhwvXgxEnHN8oJ5f@f4>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-4-jiri@resnulli.us>
 <ZhmbxntSvXrsnEG1@f4>
 <ZhqIXZYnHA0MZT3L@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhqIXZYnHA0MZT3L@nanopsycho>

On 2024-04-13 15:27 +0200, Jiri Pirko wrote:
> Fri, Apr 12, 2024 at 10:38:30PM CEST, benjamin.poirier@gmail.com wrote:
> >On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Allow driver tests to work without specifying the netdevice names.
> >> Introduce a possibility to search for available netdevices according to
> >> set driver name. Allow test to specify the name by setting
> >> NETIF_FIND_DRIVER variable.
> >> 
> >> Note that user overrides this either by passing netdevice names on the
> >> command line or by declaring NETIFS array in custom forwarding.config
> >> configuration file.
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >> 
> >> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> >> index 6f6a0f13465f..06633518b3aa 100644
> >> --- a/tools/testing/selftests/net/forwarding/lib.sh
> >> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> >> @@ -55,6 +55,9 @@ declare -A NETIFS=(
> >>  : "${NETIF_CREATE:=yes}"
> >>  : "${NETIF_TYPE:=veth}"
> >>  
> >> +# Whether to find netdevice according to the specified driver.
> >> +: "${NETIF_FIND_DRIVER:=}"
> >> +
> >
> >This section of the file sets default values for variables that can be
> >set by users in forwarding.config. NETIF_FIND_DRIVER is more like
> >NUM_NETIFS, it is set by tests, so I don't think it should be listed
> >there.
> 
> Well, currently there is a mixture of config variables and test
> definitions/requirements. For example REQUIRE_JQ, REQUIRE_MZ, REQUIRE_MTOOLS
> are not forwarding.config configurable (they are, they should not be ;))

Yes, that's true. If you prefer to leave that statement there, go ahead.

> Where do you suggest to move NETIF_FIND_DRIVER?

I would make NETIF_FIND_DRIVER like NUM_NETIFS, ie. there's no statement
setting a default value for it. And I would move the comment describing
its purpose above this new part:

> +
> +if [[ ! -z $NETIF_FIND_DRIVER ]]; then
> +	unset NETIFS
> +	declare -A NETIFS
> +	find_netif
> +fi
> +

BTW, '! -z' can be removed from that test. It's equivalent to:
if [[ $NETIF_FIND_DRIVER ]]; then

