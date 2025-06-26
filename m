Return-Path: <netdev+bounces-201704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9BBAEAB8D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD064E49D7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88C22FF35;
	Thu, 26 Jun 2025 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0kavkYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C237227563;
	Thu, 26 Jun 2025 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982364; cv=none; b=MObQOrde6qk5wlSFcl12W3G9oji5qHqq6V+dpeVHURDHpbJronr7PTPAeakMGdpj3Q/7AfoBYqPj5MrnsqD9ERxeGNaUbxD921sKyKkkLNLhDxa/JSaXIci6p7Q+mdCB2uJ2mIuJ9NOz5gyovBlVVT2S5kg6V9PEZ3ARe9ahkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982364; c=relaxed/simple;
	bh=s3rbMWUAfYhIRKU2aYRNEwpl6k00a31yw5xuU8prP3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sd4oOTUNL55jAxBhEQaO6WWW8PHXEQ3/Rr1sUjksq9/JZ7mqtP5mK93iFljZBYjuR+uN0sSuluFiA2q6VB7oyQeiQogNrduCMnZCZE9xj83408zlaMvVWnTx3Z6O9Uj+URKAfI1N2bGv96qYoBn0rMvvSu0uaOjKeSQ3MFF1Bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0kavkYh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2091445b3a.0;
        Thu, 26 Jun 2025 16:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750982362; x=1751587162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MU802fHFDsWEcG5O/JQOLJRXUp/Mx/sjo2Oncuu4jl0=;
        b=X0kavkYhkbmso2A2chS+QbB0Dq6ubpze6PY/+Mq1lIHZNHGbbsfLm6PnZY/DDkoS9m
         dVE0yT/CKaNljMsNgSpABC61/VEcs0bKgaQBn0UAYfRZDe1Bw0Fg65oDaD2VeRKQ8CGr
         1b+EC6QSFTWn/pXJVv3bDYki3SUCrjYwjWr7EoaFNGE2sTPpvXpVxBAoxdrJMWjz1JpE
         TihmJoHkFAI33v607i0U77rNOHrpeUmSWqGiJ5EzZ7ge6DLlhpB20uZLEVdEJrDGwOPv
         E6lDgV80hLtHY6CXU6MPDoorShEM66vCKw98/7p4pe4ZNY2WISZKidPeHegpXskUg+K6
         8ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750982362; x=1751587162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU802fHFDsWEcG5O/JQOLJRXUp/Mx/sjo2Oncuu4jl0=;
        b=cP8aCKTwUTJE5Loo1gnL1tNi2UwLmAzfuctHBptJrSa2rK1KIH0Detw1g/9ri7zu+n
         qdYtzZL/69zFeMgnGzppX4zSF7OtFk9gpXueRJTyp7uxGpa4hpQ+2kLHooDuK80E0P6C
         scJ6si6K3fGuqIQw6/BT1tbGkqrEhn42n8BFXS9ej0DXPa1NE6AUgbJwk9DIT1OYjPdz
         Q5zY9TDOrkVsq0EF+7iAVHVE3RQj4mdGfTiM5L2ehctfT9xIWf8MWG6HbtS7BnjRGVb3
         Ftgzsur5X+3WQUniYfYHERk3rLWDgj0qYPMfA1/bPbl9Rky/JkpfYaOpcGFY0eetIfWV
         7ynA==
X-Forwarded-Encrypted: i=1; AJvYcCUnup2SapD7Ut6nLnxNlgy2O/lBJ5s5FzISI5gn9qHw/+tf2Klf346MKIqmHu8983WH0IC17fFW@vger.kernel.org, AJvYcCW18wuw8S9AmNxBSRS+33bn0pu2ebOWDCIkm4yJmKjf8jRgB3b5DWtejk+ru/MTHrITZr/DNRAish4=@vger.kernel.org, AJvYcCXOIQLXTm45qx9nThLxtfHXqBwJjlZ1kBOB1UIZrqcUCk6uIoSaJpTbOu5uwzb6DXag7gn3VkoCt9xyLAnV@vger.kernel.org
X-Gm-Message-State: AOJu0YwuB7uZjSFTt/jFzMgFLJPjBE+agTGCPic2Rff9svsEDmsxAZG8
	w5QghO+JhLTOcsYQvbCEJ3tPMYqOFYRZFBVKegWjPqiapTGB2eze2JaM
X-Gm-Gg: ASbGncu0QpGVucmDWUYc0ZpOWhB7T4jjsCJRuQ/r1RNc0GS8YbkjBtIvUIncpN7Iy/a
	cunJ2D2gl023ax5WxUki+BHrpRFrtYubATHHGPc76k2D0w3J8EfBLLoiMKBdrV2BvpPku5/ScA7
	rYoap9it5nr2coC5mCbwhhDA0n0dxOxsyg1VHvI/I1N6gMrxFUUpLKKUSnVYRynwfQs+inl4Mop
	4EjjNHrPyrStsntc3Hn18WNfHZ+cRGUfX+WvAuUrbs/dNAWhmuYZ8beWxe9rbPnQzeB22KECt/s
	n9ZBQ/ytkeAgKqS7PF+K9aWJTdwsnbiUbAkUcgm5xvZ8EeSlMpOpClBUXev/L+i+noSDNmHUr3z
	UAoG/tWY6vrCkqiw1r7tCN7UA5vN8C85C
X-Google-Smtp-Source: AGHT+IH2QEv1EXX1AwW0bplm/IMyDMqzMeclzHruNi6dErZJ0S6a5ZLa64wP13/R2bF/xVlDw1ddCA==
X-Received: by 2002:a05:6a21:1fc3:b0:1f3:3547:f21b with SMTP id adf61e73a8af0-220a08dc64amr1126298637.5.1750982362495;
        Thu, 26 Jun 2025 16:59:22 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56cffccsm799591b3a.130.2025.06.26.16.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 16:59:22 -0700 (PDT)
Message-ID: <ebdb0f12-0573-4023-bb7f-c51a94dedb27@gmail.com>
Date: Fri, 27 Jun 2025 08:59:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/13] docs: parser_yaml.py: fix backward compatibility
 with old docutils
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>,
 Jan Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Ruben Wauters <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
 <d00a73776167e486a1804cf87746fa342294c943.1750925410.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <d00a73776167e486a1804cf87746fa342294c943.1750925410.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

On Thu, 26 Jun 2025 10:13:09 +0200, Mauro Carvalho Chehab wrote:
> As reported by Akira, older docutils versions are not compatible
> with the way some Sphinx versions send tab_width. Add a code to
> address it.
> 

Tested OK against debian:11's and almalinux:9's Sphinx 3.4.3, both of
which have docutils 0.16 bundled.

opensuse/leap:15.6's Sphinx 4.2.0 has docutils 0.16 with it, but it is
python 3.6 base and it does't work with the ynl integration.
As opensuse/leap:15.6 provides Sphinx 7.2.6 (on top of python 3.11) as
an alternative, obsoleting it should be acceptable.  

Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Closes: https://lore.kernel.org/linux-doc/598b2cb7-2fd7-4388-96ba-2ddf0ab55d2a@gmail.com/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Tested-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> ---
>  Documentation/sphinx/parser_yaml.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> index 8288e2ff7c7c..1602b31f448e 100755
> --- a/Documentation/sphinx/parser_yaml.py
> +++ b/Documentation/sphinx/parser_yaml.py
> @@ -77,6 +77,10 @@ class YamlParser(Parser):
>  
>                  result.append(line, document.current_source, lineoffset)
>  
> +            # Fix backward compatibility with docutils < 0.17.1
> +            if "tab_width" not in vars(document.settings):
> +                document.settings.tab_width = 8
> +
>              rst_parser = RSTParser()
>              rst_parser.parse('\n'.join(result), document)
>  


