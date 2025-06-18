Return-Path: <netdev+bounces-198869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B91ADE132
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E97161BB7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 02:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F431A23AF;
	Wed, 18 Jun 2025 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zeac9Oxy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEBE2D600;
	Wed, 18 Jun 2025 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214542; cv=none; b=kzQx1sLiTm7EwDBQRHAiZuM411Nn6AutHnv1mHtz9BTMlE4RhKt31AWjdDmtHLULAnjrOuQMEYK+0h+RFjchTtoCExRQMV5I1SIVShEM2/eqpCIiicK5BxzxxJ+CHFhcB5gKqasHNdxF5DtSOLuqqgyDJMTmRKFkp+HCO7FJI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214542; c=relaxed/simple;
	bh=7i5+1Vmj56/aTiTJ9aGMjarno6AIHKUGDq5Tb5xI53w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qp1uyn0t6Ihj2le3grGWwxxXCn1+khWCGHvSwU4UOhjyuubBmqgiIOh1SG7i6cIZf/loYKlcmNn/VKWIxivDhdOxsBkC3iUo7bsa+QPofMPaWLFcJe+RVjLygN305D8RsQKuNFbkhADKxL0vOGVTRI4XxrPoq+Qt9Tr/RhrWFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zeac9Oxy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234d3261631so42993285ad.1;
        Tue, 17 Jun 2025 19:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750214540; x=1750819340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fuYMA/57H5BAmU65jan5lqjjy5ZSUjRygUj6a7SK/2Y=;
        b=Zeac9OxyEjM3XiYbjjvZp1WyxDQwQA2xjSyXBDTo8KQar5w9CyV5z1e1LnUhPlBT+H
         kbSZTNd+9+QCMZeG1BrwZ9Mj6Qu7POCh2/H+He7I2bOqeviGGdyQNPCArwPsslPQeNxh
         ME9Pes/GBToONF9wFALEeYA5cJqfOZ6KZT2M/LKdrzCINC0+2M0EOb+/UrsLkoU1OnQl
         8JylhFK+OpEW81/g0cT67kDM9N7EW8FhilYbK6JqQaTZRLJ2hirOonAWSKB81mCwlE1z
         qOaJ6O4u/QzbR+2Yh7opC8+nQLYoeW0RAfvhOUnFrCaUOfwDq0h+XYyIJA8z2V/VrBUb
         03Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750214540; x=1750819340;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuYMA/57H5BAmU65jan5lqjjy5ZSUjRygUj6a7SK/2Y=;
        b=RN0cAfDPl7PYEaN7z4c1j5YW98RbhXJY4V9lUeoKb0oSSuNJM+/DARd9KpJzuTV792
         AbpYcvXdoNuO2q1wmw/BWsYIF1oZZdAoFf5gyBVjTAGDwyBkCgo3gOVF2ngGNLYYR1b1
         h1SHMNjyBmhzHKyVoZLYbxpgdObdyDl10HIJdaqtUG83RF8j1NPIr2Svr9jLuIBGmdll
         bVgTXGDt+1GzMQC3x4UaAYArRWQ2HsrtADrCsXjsOLXQIu4+BYek/ClJ/Ut1+9lbLU0L
         99iTJ8pI0sjKtp02LcBtlq54AG8+67PeNxu11IoPVHpI94ZLy8PC+zrmTKaz+Hh9xSqc
         RkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLt7hZS8zC5EcZiZi/aKkKQ3FZUKVEffYgy7rSPaO8dPnQWvyI3v7p5NmWyNcb4Pb2ivegDczC@vger.kernel.org, AJvYcCWNv8BBzDRBHDfcQfyDBhaumEVWWfeTznMvRUqZ+5TX+8u42ePazKVmlX9H1qPrIkSk19zusnMhGrM=@vger.kernel.org, AJvYcCX3bKc1k9nL8NmLE0M/fJjhFhsmIrOC+irLpZpoRatQmW64CcN8XTzjPCVth1qhZN3lzewAKtE/nAyq8oeB@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKKhNMC4br6m60dJVgX42JDvHhOfY2TP/NOB5kA/1bz0JYkHR
	BPZE1ZNmOnpeRI0n2Sy/unAoXZn9ZRUDd+CtLhfSZAfj9nnzVrN4gTX5
X-Gm-Gg: ASbGnctElc4OdgGyfJkfiX9wCx6gbIb/azu8BWb1E5pKD7m3+xvV3XqN6Zyp5aBaexM
	Cker3lhgf/tsEBis4cIdHFwWFVfo8cGXBTHuEaae6KbCEsPFlng8sGZY6eV5xncO9MKRb7xk6H8
	DhCjx6AZBccLeTVQL4dfwzCZgxafOpmpKXHdCTNBE9tvPtMhSqUIBu3ccuvwOGgWR/vYkWykARj
	xo12PDQapS+ZiSWTTX2pNCVbs975WuwjugIAssmGu/UN+QYiaRHgQBJswsoskJ3r9mNckg3+Ex2
	zfcv0j3YWNY6hITZIlLrZOHo6593sYdzaHW1tQ960YTHP5aKSDW0U1PJFVfB9Md4MAbahXzIXGV
	t1ct3eqXVfiYoIqiwvB+dm3vBNf08EtDt
X-Google-Smtp-Source: AGHT+IHvoHz8x/cvMCuTAeyI0cA9D+sbDRrQQCvuQAcnDzndTzmiRTQy44tnbpaZaEQHbGQzSCzMBg==
X-Received: by 2002:a17:903:2347:b0:235:91a:4d with SMTP id d9443c01a7336-2366b0185e5mr212827035ad.23.1750214539698;
        Tue, 17 Jun 2025 19:42:19 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfc68c1sm88027995ad.238.2025.06.17.19.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 19:42:19 -0700 (PDT)
Message-ID: <1adba2c6-e4c3-4da2-874e-a304a1fdfd25@gmail.com>
Date: Wed, 18 Jun 2025 11:42:14 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v5 01/15] docs: conf.py: properly handle include and
 exclude patterns
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>,
 Jan Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
 <cca10f879998c8f0ea78658bf9eabf94beb0af2b.1750146719.git.mchehab+huawei@kernel.org>
Content-Language: en-US
In-Reply-To: <cca10f879998c8f0ea78658bf9eabf94beb0af2b.1750146719.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

A comment on compatibility with earlier Sphinx.

On Tue, 17 Jun 2025 10:01:58 +0200, Mauro Carvalho Chehab wrote:
> When one does:
> 	make SPHINXDIRS="foo" htmldocs
> 
> All patterns would be relative to Documentation/foo, which
> causes the include/exclude patterns like:
> 
> 	include_patterns = [
> 		...
> 		f'foo/*.{ext}',
> 	]
> 
> to break. This is not what it is expected. Address it by
> adding a logic to dynamically adjust the pattern when
> SPHINXDIRS is used.
> 
> That allows adding parsers for other file types.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/conf.py | 52 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 12de52a2b17e..e887c1b786a4 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -17,6 +17,54 @@ import os
>  import sphinx
>  import shutil
>  
> +# Location of Documentation/ directory
> +doctree = os.path.abspath('.')
> +
> +# List of patterns that don't contain directory names, in glob format.
> +include_patterns = ['**.rst']
> +exclude_patterns = []
> +

Where "exclude_patterns" has been with us ever since Sphinx 1.0,
"include_patterns" was added fairly recently in Sphinx 5.1 [1].

[1]: https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-include_patterns

So, this breaks earlier Sphinx versions.

Also, after applying all of v5 on top of docs-next, I see these new
warnings with Sphinx 7.2.6 (of Ubuntu 24.04):

/<srcdir>/Documentation/output/ca.h.rst: WARNING: document isn't included in any toctree
/<srcdir>/Documentation/output/cec.h.rst: WARNING: document isn't included in any toctree
/<srcdir>/Documentation/output/dmx.h.rst: WARNING: document isn't included in any toctree
/<srcdir>/Documentation/output/frontend.h.rst: WARNING: document isn't included in any toctree
/<srcdir>/Documentation/output/lirc.h.rst: WARNING: document isn't included in any toctree
/<srcdir>/Documentation/output/media.h.rst: WARNING: document isn't included in any toctree
/<srcdir>/Documentation/output/net.h.rst: WARNING: document isn't included in any toctree
/<srcdir>/Documentation/output/videodev2.h.rst: WARNING: document isn't included in any toctree

Sphinx 7.3.7 and later are free of them.  I have no idea which change in
Sphinx 7.3 got rid of them.

Now that the parallel build performance regression has be resolved in
Sphinx 7.4, I don't think there is much demand for keeping Sphinx versions
compatible.
These build errors and extra warnings would encourage people to upgrade
there Sphinx.  So I'm not going to nack this.

Of course, getting rid of above warnings with < Sphinx 7.3 would be ideal.

        Thanks, Akira

> +# List of patterns that contain directory names in glob format.
> +dyn_include_patterns = []
> +dyn_exclude_patterns = ['output']
> +
[...]

