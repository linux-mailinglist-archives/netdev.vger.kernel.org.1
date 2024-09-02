Return-Path: <netdev+bounces-124142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032B968503
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD6E1F21207
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F7143878;
	Mon,  2 Sep 2024 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIbN3vnU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5213B2A8;
	Mon,  2 Sep 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273688; cv=none; b=JETdLPbI77dsapKsTlpl083l2vRb0GM7uL3Rl1KxrIVdykr0GGAsR5BkTDcEKms19RZOOzcwche7HrjsVWliImgjpEccaLYlKN7G7tHHsLfC+CY0sXkN7O7svwGnf5Cx9R9FNQE+Xru9zWw5FKiCRUm1cVQ13T0aMbuiIVa9Vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273688; c=relaxed/simple;
	bh=0r45B5aFyCMHgKXSBqq3z6fkz98xzlyNLXrUbrBBjIs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=QY5ngyOzMyTDuCIA/NiEDQZz8cXjRYpTBNJc3cNE1TEGWis8UZvesoEvTBYmHX5GXF9XaB5pI7ZwOmWvfJzBoLINkEiVcEw593DF/L9yy0PqqwIQIvNXQekJ/ulwIWOh8ShfK0CK0RcEWB5GTcaLKE2ni2rEYx5KT+sjkY4Cy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIbN3vnU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so1160633a12.1;
        Mon, 02 Sep 2024 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725273685; x=1725878485; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYFvd3mndntXawAb+f+Hoo4lqWFTYRrIZXzGbH72ilg=;
        b=GIbN3vnUGhBoCO9ToGIcFBeAZCwc7qfmmDrvGAUp7O617KA3veCWlJEUF25Kfu75om
         CUNn6FKh7ZOJJwwkDlMruUlhFzBglHJf8W06+RDs09DkJYa9g7b9xWC53GTINvj+r/cU
         URwWEbLKudI3L3hB7GCIgfgUTGriPzA3tTKb3nd4NnaRhTZPAahlCXkSjpXvASDSfyWa
         P7SaYkO92jiEaljDQ6VHb828Hm8z7W+ky9gcKvoTMBMswmTi2sp8SA/T/DCs2aNpfarr
         wvoG0d0cHNeFHIkYtgS6VlytcjpFFGyZmJUL2yzoVgBz9K8uhS8nbw2+Wtb+ozqhXL9h
         FSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273685; x=1725878485;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYFvd3mndntXawAb+f+Hoo4lqWFTYRrIZXzGbH72ilg=;
        b=u0VrWZOQRzSLuZbyTWkxlOfvH33/HloH5mWgmQLm7uOV5jECMeL8luY4mCRGjgb01e
         uPrp9143F+0yqaZA7mrvYTK/QOPjTSqphrdirjqDLoE/EW6ocfZNibU9VM5oLmANuB0A
         J5XfMsrawttAbG5lUwE2WXsZUMjyhMf19L52QU5nHmjfqpjud+IAR23Dwf/PFS0hjVxu
         Tj7LShSeIkM6hq2/13T8lTq5lp+BpurgiSzVP0JCowduslfOnuiqHt3YuJwldp7ncntN
         jIxWE8D1FQ3vkqUyKLq9AkOz0SIAAjLNoLhlagsS9O3coWgE2eTepwbrzrI4JQv1E5yc
         qcAA==
X-Forwarded-Encrypted: i=1; AJvYcCWIWmmfoBKaqdpIRQisShpzIU++ftNe7KK9Is6uQ7iYBgqr+ktw+v5hr57uyopxpZWg+cFWXvhdhu1Zvtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlw50DHW9e73d6U8OA6vMozmR8DTjZSqVhOGw1r1FyMYG1eH9
	kFi8kuYr0YG4kf5/+kE91YIY648Mtm2+fMWFRnXr2xipr+6PvRNDxuhPVw==
X-Google-Smtp-Source: AGHT+IHY5R6FJqEx2OwECLZMjmWk695QObQE23ePtacPm0xUP/4ZMARX2OD68jnP41ydkqkKRzAAlQ==
X-Received: by 2002:a05:6402:13d1:b0:5b9:3846:8bb3 with SMTP id 4fb4d7f45d1cf-5c25c3ad6e1mr2246921a12.12.1725273684250;
        Mon, 02 Sep 2024 03:41:24 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:54ae:7bbe:cc21:9185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c076sm5119694a12.46.2024.09.02.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:41:23 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org,  kuba@kernel.org,  davem@davemloft.net,
  edumazet@google.com,  pabeni@redhat.com,  jiri@resnulli.us,
  jacob.e.keller@intel.com,  liuhangbin@gmail.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tools/net/ynl: fix cli.py --subscribe feature
In-Reply-To: <20240830201321.292593-1-arkadiusz.kubalewski@intel.com>
	(Arkadiusz Kubalewski's message of "Fri, 30 Aug 2024 22:13:21 +0200")
Date: Mon, 02 Sep 2024 10:51:13 +0100
Message-ID: <m2mskq2xke.fsf@gmail.com>
References: <20240830201321.292593-1-arkadiusz.kubalewski@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com> writes:

> Execution of command:
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml /
> 	--subscribe "monitor" --sleep 10
> fails with:
>   File "/repo/./tools/net/ynl/cli.py", line 109, in main
>     ynl.check_ntf()
>   File "/repo/tools/net/ynl/lib/ynl.py", line 924, in check_ntf
>     op = self.rsp_by_value[nl_msg.cmd()]
> KeyError: 19
>
> Parsing Generic Netlink notification messages performs lookup for op in
> the message. The message was not yet decoded, and is not yet considered
> GenlMsg, thus msg.cmd() returns Generic Netlink family id (19) instead of
> proper notification command id (i.e.: DPLL_CMD_PIN_CHANGE_NTF=13).
>
> Allow the op to be obtained within NetlinkProtocol.decode(..) itself if the
> op was not passed to the decode function, thus allow parsing of Generic
> Netlink notifications without causing the failure.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Link: https://lore.kernel.org/netdev/m2le0n5xpn.fsf@gmail.com/
> Fixes: 0a966d606c68 ("tools/net/ynl: Fix extack decoding for directional ops")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

