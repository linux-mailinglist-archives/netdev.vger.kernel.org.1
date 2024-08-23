Return-Path: <netdev+bounces-121307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA495CAA4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347B41F23CFC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9FD18732C;
	Fri, 23 Aug 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHwbHTlA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219ED185B78;
	Fri, 23 Aug 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409636; cv=none; b=Hbom8z8r9cYxjm2XdE/L0fkQHnSSKjRbVXY9k9Za6MNrXu8AchwqNqA4K2fdHz2DXdqDakmoL/GkJ0yBW7YT/xSWMrqcGBHaeeXLaM8Jvc2cn61fzti2agE3gK0kgoZ/DQW3JSxNvGn9uA6/2Wx2tYvJ1liadEW1oog+fw+rkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409636; c=relaxed/simple;
	bh=//eBAx5ayciE8pqSbWnJ5Tdkz3lknEoUh6KHr54s4X8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=YDtb8DgocRzj7iP1snh44D/tFnqtnE/XzcXq2Wugeovj+MKoGmlBZBDj27MxukNZc7tsth+YKFzTvMcaF/m25/otq/LcQrWVTxwGQu8mPL56nHKW7IpSfUUcEJW6CgiJqm4VIyCZHzpkNmE6/de1QMZrsH8pC5XKwkNA2CFODxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHwbHTlA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bed83487aeso2068312a12.2;
        Fri, 23 Aug 2024 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724409633; x=1725014433; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFjTPKl14yFOGKq8whMu1WpoYK95xMVkbR4vqEr+yGQ=;
        b=QHwbHTlAQs0jnfaUfkDEn9vwMyDr59bZ5Q/YjI8WnA0FeDP0P4QhCWao181WqNyahN
         9/YUnbHRHXDIir+TJ2Ds7TeJX5LCl904coPrBi8UcUNgd56+EotCaKWP+8revhrbZbxC
         RmqpvTSkGhrnfZX+IpTVidHcN8jeG2MsDXP/5HouXqEB5SYD/t10b7CwMl151m26FZ+w
         DI70bemkG1+d3CtgWcZh+wuyrnozU0TEzvfxcRRHDlJH/PrJJcLsrlPC/Dti0j5Ffq+t
         rZWaBI8HMdoPLDfe3/qVrONsfl97wJH/P8LalXmnVu5jODt4dEt2Lngs/t+oxLeTO95d
         9L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724409633; x=1725014433;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFjTPKl14yFOGKq8whMu1WpoYK95xMVkbR4vqEr+yGQ=;
        b=tc9EaexkAvXv9h68+HzY7iBHJyRr1pCGbD7rB6RB1WwXXGL/qyoh+OrP2ZZVe38IPx
         6HEw8ewKl+3F0pDJb/I1yDKajdMkJhZkoBjBgQxVOUZ0Ihpr0J6j1YcbLL5dYZP09F6r
         N8S4ss6ECd0qP0Otgtwr2ojGs3ky6QPv7okIcE7eN3BAMB3p8LXLnKXz1lk1ZxQgkq+p
         VYuim2zeivR5apr/N+JuSjaniLLDK8q5StdTbU75Jg/tIhued3kjA1hVAhGDQ6QxXqfM
         gehu4gF6+ly1xIw+3aDYL5XJ91UcRx3G8bOgmmlp3/0ngZCtuwCkdgn6B+N+PfN+1JW9
         TQow==
X-Forwarded-Encrypted: i=1; AJvYcCUOD8MGccw3XOeBuFY8OOEnubAcQNGdn533Zl6ytSaX0GLPrCMYEQNBNJtwopVNNaYZFl9VMte+b48G7wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CgVt6Sv/eK7Nhabpd/3TCYXDAJWv5IAeQNJsMRfrIEyhr+bx
	BHOseCVt8a98edLs+WfgwnvKtdmStrY+AWfhf93fHU8xCddsovCcf5NSNBjF
X-Google-Smtp-Source: AGHT+IHtXLM3XvtO1hSrQll3WP5w+vaps0BU5jjZG/fUuFByZyn4sDJUjIxvFWnFcs/c4Cog8hJkiQ==
X-Received: by 2002:a17:907:e228:b0:a80:7193:bd93 with SMTP id a640c23a62f3a-a86a52b897emr131418966b.25.1724409632737;
        Fri, 23 Aug 2024 03:40:32 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2159:e77a:3088:8b3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f437c5csm240094066b.124.2024.08.23.03.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:40:32 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org,  kuba@kernel.org,  davem@davemloft.net,
  edumazet@google.com,  pabeni@redhat.com,  jiri@resnulli.us,
  jacob.e.keller@intel.com,  liuhangbin@gmail.com,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net] tools/net/ynl: fix cli.py --subscribe feature
In-Reply-To: <20240823084220.258965-1-arkadiusz.kubalewski@intel.com>
	(Arkadiusz Kubalewski's message of "Fri, 23 Aug 2024 10:42:20 +0200")
Date: Fri, 23 Aug 2024 11:40:20 +0100
Message-ID: <m2le0n5xpn.fsf@gmail.com>
References: <20240823084220.258965-1-arkadiusz.kubalewski@intel.com>
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
> Traceback (most recent call last):
>   File "/root/arek/linux-dpll/./tools/net/ynl/cli.py", line 114, in <module>
>     main()
>   File "/root/arek/linux-dpll/./tools/net/ynl/cli.py", line 109, in main
>     ynl.check_ntf()
>   File "/root/arek/linux-dpll/tools/net/ynl/lib/ynl.py", line 924, in check_ntf
>     op = self.rsp_by_value[nl_msg.cmd()]
> KeyError: 19
>
> The key value of 19 returned from nl_msg.cmd() is a received message
> header's nl_type, which is the id value of generic netlink family being
> addressed in the OS on subscribing. It is wrong to use it for decoding
> the notification. Expected notification message on dpll subsystem is
> DPLL_CMD_PIN_CHANGE_NTF=13, seems at that point only available as first
> byte of RAW message payload, use it to target correct op and allow further
> parsing.
>
> Fixes: "0a966d606c68" ("tools/net/ynl: Fix extack decoding for directional ops")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  tools/net/ynl/lib/ynl.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index d42c1d605969..192d6c150303 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -921,7 +921,7 @@ class YnlFamily(SpecFamily):
>                      print("Netlink done while checking for ntf!?")
>                      continue
>  
> -                op = self.rsp_by_value[nl_msg.cmd()]
> +                op = self.rsp_by_value[nl_msg.raw[0]]

I don't think that is the right fix. It would break notifications for
raw netlink messages. The point of NlMsg.cmd() is to abstract away where
the op id comes from. GenlMsg.cmd() returns the value unpacked from
raw[0].

The problem is that we are trying to look up the op before calling
nlproto.decode(...) but it wants to know the op to check if it has a
fixed header.

I think the fix would be to change NetlinkProtocol.decode() to perform
the op lookup, if necessary, after it has called self._decode() to
unpack the GenlMsg.

How about changing NetlinkProtocol.decode() to be:

def decode(self, ynl, nl_msg, op, ops_by_value):
    msg = self._decode(nl_msg)
    if op is None:
        op = ops_by_value[msg.cmd()]
    ...

The main loop can call it like this:

nlproto.decode(self, nl_msg, op, self.rsp_by_value)

and check_ntf() can call it like this:

nlproto.decode(self, nl_msg, None, self.rsp_by_value)

>                  decoded = self.nlproto.decode(self, nl_msg, op)
>                  if decoded.cmd() not in self.async_msg_ids:
>                      print("Unexpected msg id done while checking for ntf", decoded)

