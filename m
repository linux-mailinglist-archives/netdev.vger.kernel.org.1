Return-Path: <netdev+bounces-136166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8F9A0BC5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E06284BB0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E26206E96;
	Wed, 16 Oct 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLiRBi62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14E125B9;
	Wed, 16 Oct 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086037; cv=none; b=Un2JlKxXtRJLa7l+mLzO/XChZV2/PWD0IfbXmxzfOvAqBkxJMXCVvMfxCjZ26y9l6eXJhMOKbJV5NFG2jRSbYoZxEV8WpBNTewmDswt99XEOqjErNEARy1RRvnkyYoA4K1/A0FfhYneF62u6W5z7AZSzUTlQezTjwYbAmFC9bNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086037; c=relaxed/simple;
	bh=G++ORK2FgZevGvdY+BTR6KcoC7OqkSgsfdR9UEvc5pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW/SXzKy5mTHys67bp4R5sQF3pl5nSIwNXek3VrqGTobXf28rWMzPCyHAPImO+hPwqKZGSSSWLAjMMpIWtLcEGrpd36oQ32WIVugRqEx028dHxzsiGzV8aqhBFpMtMY2IYC2QaBEH/lelPJYRJ8xEplXeobmp49CDn2dTHcsyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLiRBi62; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4314ff68358so1261295e9.1;
        Wed, 16 Oct 2024 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729086035; x=1729690835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8+QnUShLc/0+IHM+m9BqL3B3PrvM4XJTQxj3ySk1rs=;
        b=FLiRBi62Ymu/kx0f6SSj2sB8uUvfIU9fihnxFjVBszpG8eh6IkDwGYhcuzQ9Zjty48
         lF4soTYUre4hw3pZA2weBWpO9V16wjkAgVfmHAZP19qE7DqnMi+i6Qj3ibuilVthODIL
         uu+zhIhd/WV89BivDBmvG/bvZRrDueA0g21InuRh8FkfERO01vX3DXj9cQktwvFz7q7e
         qdvMrwIz/S4iw7VQicjx2hXGHEmJA374CsvtlRTNvdLo2ICINYulcnhVFXXbHlWbsncm
         FGQTztt7snEDnbvPja9B261sBBMMqEGYWbz/aGolaXap/wfcK1VeCg3SeTCKFfhJ9z+6
         ry2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729086035; x=1729690835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8+QnUShLc/0+IHM+m9BqL3B3PrvM4XJTQxj3ySk1rs=;
        b=iTZC7hTBJBkWyXA3+f3NM621fwUh0iRlHxPXm4dFxpd5RyR9CXfw8U1Uv/wZbYy2eZ
         WN1KCx3EAO5G1Tjs68oeFaGPcdG1ZIpwtPndKw6WVZ8yvJ2PqMzPWYSDAbdEj73VpqaU
         +g4J6dKPVWiqUOwnXxiOhRpNzYornPUWJQtfoRWdPj9QE0eEwtqgETMT5kkfTt1BqxHi
         NlB7FB0WGRFK5aMTOPk0S4WJI58MHIRqMrR9CbxCWjRsHlJT/GHpXoR0Zv6F5rP63LP5
         YoN6kI1fLwvUICvlXY3/GysMGwZPMUxZoL0qvunZQKTcHlrAPLxqF/p2kxYHBW4B64sB
         reZg==
X-Forwarded-Encrypted: i=1; AJvYcCVhJlJjdIJqEiegyjyDzN1QmpJiRJcUupgIqApT0PLvvWff8xLT6JAbx1jaUJJ0ovKJriTSsGBS@vger.kernel.org, AJvYcCXhdIGUMvTpKvRZGdvvNSOLopA3+ORIxI0twI/nrf9OhWOnek/OqSMhXS3JUsF8P5Cs6hzcZjw6iw0ssuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Qigtqtz87X5D0zTWFvEZVq8UGUYWtiJbRxPRUHhl5oa48nkO
	u1FmHIajOH+wDF8KgVVen6hvp6acvfWy/abhMvaUJLSgPzq6g5oa
X-Google-Smtp-Source: AGHT+IFYU0g4E6OJoqqKxOHSnMeeJNON1t/f2Dc5TZXb9Hbv/s4VzmQuXbC0K1Smyh0vOOfE3l6kRQ==
X-Received: by 2002:a05:600c:1ca4:b0:42c:c59a:ac21 with SMTP id 5b1f17b1804b1-4311deae91bmr74783345e9.2.1729086034401;
        Wed, 16 Oct 2024 06:40:34 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56a583sm49608605e9.19.2024.10.16.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:40:33 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:40:30 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 3/8] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241016134030.mzglrc245gh257mg@skbuf>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-3-d9b1f7500740@intel.com>
 <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <601668d5-2ed2-4471-9c4f-c16912dd59a5@intel.com>

On Wed, Oct 16, 2024 at 03:02:38PM +0200, Przemek Kitszel wrote:
> On 10/11/24 20:48, Jacob Keller wrote:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > 
> > This is new API which caters to the following requirements:
> > 
> > - Pack or unpack a large number of fields to/from a buffer with a small
> >    code footprint. The current alternative is to open-code a large number
> >    of calls to pack() and unpack(), or to use packing() to reduce that
> >    number to half. But packing() is not const-correct.
> > 
> > - Use unpacked numbers stored in variables smaller than u64. This
> >    reduces the rodata footprint of the stored field arrays.
> > 
> > - Perform error checking at compile time, rather than at runtime, and
> >    return void from the API functions. To that end, we introduce
> >    CHECK_PACKED_FIELD_*() macros to be used on the arrays of packed
> >    fields. Note: the C preprocessor can't generate variable-length code
> >    (loops),  as would be required for array-style definitions of struct
> >    packed_field arrays. So the sanity checks use code generation at
> >    compile time to $KBUILD_OUTPUT/include/generated/packing-checks.h.
> >    There are explicit macros for sanity-checking arrays of 1 packed
> >    field, 2 packed fields, 3 packed fields, ..., all the way to 50 packed
> >    fields. In practice, the sja1105 driver will actually need the variant
> >    with 40 fields. This isn't as bad as it seems: feeding a 39 entry
> >    sized array into the CHECK_PACKED_FIELDS_40() macro will actually
> >    generate a compilation error, so mistakes are very likely to be caught
> >    by the developer and thus are not a problem.
> > 
> > - Reduced rodata footprint for the storage of the packed field arrays.
> >    To that end, we have struct packed_field_s (small) and packed_field_m
> >    (medium). More can be added as needed (unlikely for now). On these
> >    types, the same generic pack_fields() and unpack_fields() API can be
> >    used, thanks to the new C11 _Generic() selection feature, which can
> >    call pack_fields_s() or pack_fields_m(), depending on the type of the
> >    "fields" array - a simplistic form of polymorphism. It is evaluated at
> >    compile time which function will actually be called.
> > 
> > Over time, packing() is expected to be completely replaced either with
> > pack() or with pack_fields().
> > 
> > Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >   include/linux/packing.h  |  69 ++++++++++++++++++++++
> >   lib/gen_packing_checks.c |  31 ++++++++++
> >   lib/packing.c            | 149 ++++++++++++++++++++++++++++++++++++++++++++++-
> >   Kbuild                   |  13 ++++-
> >   4 files changed, 259 insertions(+), 3 deletions(-)
> 
> 
> > diff --git a/lib/gen_packing_checks.c b/lib/gen_packing_checks.c
> > new file mode 100644
> > index 000000000000..3213c858c2fe
> > --- /dev/null
> > +++ b/lib/gen_packing_checks.c
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdio.h>
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	printf("/* Automatically generated - do not edit */\n\n");
> > +	printf("#ifndef GENERATED_PACKING_CHECKS_H\n");
> > +	printf("#define GENERATED_PACKING_CHECKS_H\n\n");
> > +
> > +	for (int i = 1; i <= 50; i++) {
> 
> either you missed my question, or I have missed your reply during
> internal round of review, but:
> 
> do we need 50? that means 1MB file, while it is 10x smaller for n=27

The sja1105 driver will need checks for arrays of 40 fields, it's in the
commit message. Though if the file size is going to generate comments
even at this initial dimension, then maybe it isn't the best way forward...

Suggestions for how to scale up the compile-time checks?

Originally the CHECK_PACKED_FIELD_OVERLAP() weren't the cartesian
product of all array elements. I just assumed that the field array would
be ordered from MSB to LSB. But then, Jacob wondered why the order isn't
from LSB to MSB. The presence/absence of the QUIRK_LSW32_IS_FIRST quirk
seems to influence the perception of which field layout is natural.
So the full-blown current overlap check is the compromise to use the
same sanity check macros everywhere. Otherwise, we'd have to introduce
CHECK_PACKED_FIELDS_5_UP() and CHECK_PACKED_FIELDS_5_DOWN(), and
although even that would be smaller in size than the full cartesian
product, it's harder to use IMO.

> > +		printf("#define CHECK_PACKED_FIELDS_%d(fields, pbuflen) \\\n", i);
> > +		printf("\t({ typeof(&(fields)[0]) _f = (fields); typeof(pbuflen) _len = (pbuflen); \\\n");
> > +		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
> > +		for (int j = 0; j < i; j++) {
> > +			int final = (i == 1);
> 
> you could replace both @final variables and ternary operators from
> the prints by simply moving the final "})\n" outside the loops

I don't see how, could you illustrate with some code? (assuming you're
not proposing to change the generated output?) Even if you move the
final "})\n" outside the loop, I'm not seeing how you would avoid
printing the last " \\" without keeping track of the "final" variable
anyway, point at which you're better off with the ternary than yet
another printf() call?

> > +
> > +			printf("\tCHECK_PACKED_FIELD(_f[%d], _len);%s\n",
> > +			       j, final ? " })\n" : " \\");
> > +		}
> > +		for (int j = 1; j < i; j++) {
> > +			for (int k = 0; k < j; k++) {
> > +				int final = (j == i - 1) && (k == j - 1);
> > +
> > +				printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[%d], _f[%d]);%s\n",
> > +				       k, j, final ? " })\n" : " \\");
> > +			}
> > +		}
> > +	}
> > +
> > +	printf("#endif /* GENERATED_PACKING_CHECKS_H */\n");
> > +}

