Return-Path: <netdev+bounces-83336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBE891F93
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AA21F28D39
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84A144D12;
	Fri, 29 Mar 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2dffwgc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3211EF0D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719480; cv=none; b=VX9EDv7MIKqD+sSNOctsEe302YTBRCXWkOQRZJrYJHBW2dapuELctGbqBNKjBmiowQAAZjxVtX7R9TLnWzMhZg4JxbNLgWQr5Nv30kKOoC/oZY4/G2RmBVFJoW3Bdr21jXM9ZPs6771l7hVnyDtjYS1x2h063RXBREJcVhwVPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719480; c=relaxed/simple;
	bh=hl/VIISHJMpY7fZs9Q4FgLg+tP1Gc1fAttF5wf4KVUA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=NzZDCCTl/kYiMdht6HvuZuiPUPyllcGW/t/qfH5NcAfRqiMRF8xM6INVVDb8ji2mmw0jdq9zPyzbYJ9yjmMFk1hXOH7tj0Eiapcbj8EbWW+JR1lKRg5ImDyRVUOdhx17MIPyHfXNEu5lzyATZeIy0Z3xrTPGMCrlLNPuQS5msrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2dffwgc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41549a9dcbaso9129135e9.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711719477; x=1712324277; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNiY54YNPxaBXI0bR/OHJuKrOgeYs1TOeseNtsXSNAU=;
        b=G2dffwgcGjRaWtBQNgfz/jWYDsAxQPdYwzBB56/P8C9GYaCvSaRZSS557p0WIfHvzP
         +nh8DtMaT8OCXh04QpPVoHu23OmsGaSzfxf7n0Ual1g/QYV/XGQxLvSxoy/NTGyhAfjy
         ty7dCGYUXfRbofoqlmE/Riyl3ujaH7e8Uk4NOYCNc/JDy0SHMLBOSc0ZDoTk2eE1N1Iy
         aQNBByOHew8gxcbO1FJF4r9FFIilMWLhu7H117fn0AOzMph/KlL2qhsG2osOTxru1XmI
         3C1fdCYtpHXCOoK88S/CJLKqH9RX5Yn10ZkiuxzufYuze/cNoB/FcjDMJxWphlo0fPr4
         8pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711719477; x=1712324277;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNiY54YNPxaBXI0bR/OHJuKrOgeYs1TOeseNtsXSNAU=;
        b=IrTDMkjoDFWLyHCfRKV2p2g2Xxw0zl5c7SK/4gea2zqHMi+pnEvx90WvsWKei0KqIq
         Yl3w/1ceiJNiPOdjY85WYBNcSSTkey9F2AscDLPzDi1UeFxG5MuUU/WvAtWXhwCF1WS7
         4iqNYO98j2CTdmaZCJYNqrr7MQEu6PsbUQwkXAOdq8ssPFsgf2JZ50lGtk9IjjMSbVLr
         o1nyaV0MFZPBd6XJJbCOpVax2QVDPBpECGp6j5qubo2QVmf3Y9FF3q5ZtsyXgYLYxSL8
         EtOjyLw7PRAVML8//dW4poCb25wbu1pDMf/3fZHgmlvKfQ/x09fNICpKMqnygc+esmCd
         TiVw==
X-Gm-Message-State: AOJu0YxjYcoucrKwnvIT9MNC9DTmVtEG7k2xiX7s6HdLPmXESHs8iUU2
	9WiQ25E3ngilr3/paZJtZxFjJFWtPuF0PYV2UJxy/EYiuKa1RJJF
X-Google-Smtp-Source: AGHT+IH3qB+SBMHjRo9DrnBPgpfrVdNZIY0gKIfu0ncS40zywNCKUTNvjnDYHztOANxWy9xuPLr8Pg==
X-Received: by 2002:a05:600c:45c7:b0:414:204:df50 with SMTP id s7-20020a05600c45c700b004140204df50mr1697554wmo.4.1711719477545;
        Fri, 29 Mar 2024 06:37:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:3c9d:7a51:4242:88e2])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b00415514e4c7dsm1399060wmr.4.2024.03.29.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:37:57 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Jacob Keller <jacob.e.keller@intel.com>,
  Stanislav Fomichev <sdf@google.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message
 support to ynl
In-Reply-To: <20240328175729.15208f4a@kernel.org> (Jakub Kicinski's message of
	"Thu, 28 Mar 2024 17:57:29 -0700")
Date: Fri, 29 Mar 2024 13:37:31 +0000
Message-ID: <m234s9jh0k.fsf@gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<20240327181700.77940-3-donald.hunter@gmail.com>
	<20240328175729.15208f4a@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 27 Mar 2024 18:17:00 +0000 Donald Hunter wrote:
>> -    parser = argparse.ArgumentParser(description='YNL CLI sample')
>> +    description = """
>> +    YNL CLI utility - a general purpose netlink utility that uses YNL specs
>
> YNL specs is intentional or should have been YAML? :)

I'm not sure it was intentional, but YAML is definitely better :-)

>> +    to drive protocol encoding and decoding.
>> +    """
>> +    epilog = """
>> +    The --multi option can be repeated to include several operations
>> +    in the same netlink payload.
>> +    """
>> +
>> +    parser = argparse.ArgumentParser(description=description,
>> +                                     epilog=epilog)
>>      parser.add_argument('--spec', dest='spec', type=str, required=True)
>>      parser.add_argument('--schema', dest='schema', type=str)
>>      parser.add_argument('--no-schema', action='store_true')
>>      parser.add_argument('--json', dest='json_text', type=str)
>> -    parser.add_argument('--do', dest='do', type=str)
>> -    parser.add_argument('--dump', dest='dump', type=str)
>> +    parser.add_argument('--do', dest='do', metavar='OPERATION', type=str)
>> +    parser.add_argument('--dump', dest='dump', metavar='OPERATION', type=str)
>>      parser.add_argument('--sleep', dest='sleep', type=int)
>>      parser.add_argument('--subscribe', dest='ntf', type=str)
>>      parser.add_argument('--replace', dest='flags', action='append_const',
>> @@ -40,6 +50,8 @@ def main():
>>      parser.add_argument('--output-json', action='store_true')
>>      parser.add_argument('--dbg-small-recv', default=0, const=4000,
>>                          action='store', nargs='?', type=int)
>> +    parser.add_argument('--multi', dest='multi', nargs=2, action='append',
>> +                        metavar=('OPERATION', 'JSON_TEXT'), type=str)
>
> We'd only support multiple "do" requests, I wonder if we should somehow
> call this out. Is --multi-do unnecessary extra typing?

I prefer --multi but will update the help text to say "DO-OPERATIION"
and "... several do operations".

> Code itself looks pretty good!

