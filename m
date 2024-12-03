Return-Path: <netdev+bounces-148499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F59E1DAB
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E39B165BDC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527BF1EF08F;
	Tue,  3 Dec 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8fCtLok"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB37192D98
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232996; cv=none; b=KF2PUPbqb146vejarHkZ5+K+bAD3PDkoehGsbJmcnHP5pO+sFWR33AklnIy6GXHL98ICligdLaAykd10yQ/h0qrreTE/c0Qgh3/pnQ2BCeVjguotd7phGqS1ZUNo3iyAmN+jUsd3Y9hYAbCJLGyDQoJIgI+UQelvPeAN+jxkThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232996; c=relaxed/simple;
	bh=jNWsPdr4saCtnn86TPErzrzV6o75e5tigSeHxTxMDKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeZVdzGCSfHmhA9v806lXpmwusnn6OmqtTmPy7H5PJ8+qN+0R0bFa7YMdJGIl1Ocgfr/1BnZtBNHQ7rGBKpTlzhr/mExY3gCMuTIwZNDTEUVfbBWGymUO3l2tNCXYvhvhG7h+wOFDa0yIXL0CO3YZ8UzuPiELPpSnk70S9YWCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8fCtLok; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e5b43350so118574f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 05:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733232992; x=1733837792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95bTS2N7bKNYNHhGvPAl/B+i1U0uHdfp/UTRJacxumA=;
        b=l8fCtLokj2uXljrqQHQTcs+RNQqgTJ7xLPT2LHht2uR0c9CliJJI0txvELitYn0YFF
         z8PV64RnwchgHyQ/fK5zvmYA3fQ+FrE9f7oPp2JiDOqxapO4V3ryh9rPzLoKLhholtti
         8Rw4P2KUVMJ4I5Mdia9ux21rpPrRkWByr4KQDeJ5HqjBLJW15X4VOkfG0OW/WGjiO+6Z
         1Dad1BqB9P1OXv9/KBJPiE9/MLGq8t8EGr0O/S555twpuDzgMe9Aqboa/sXKAv0H1rmG
         YVW52kQ3FNhsqME0wbY3gSlAtUrX5/u/bj0dE+iPzqlCY9CrEVFvo/djmSnr7ABlzTPC
         GDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232992; x=1733837792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95bTS2N7bKNYNHhGvPAl/B+i1U0uHdfp/UTRJacxumA=;
        b=lQVkNl0AVrRR5eFp0zvjp8GJq4SGybDxsweUK0CmNqRbzVwsyViZP7mwhuqVoovZLq
         nnuwUj2qfkdjqyG7o6oDX9nvPz4Evs5aqFx86a5Te43uvOY1vZE2pH1QnyHLNKnLUVec
         xEqkT97i7tfWDKQvhN3YwBiTbBCkB5sChsXj0MVJl2nu/iPxhNrmUx6vMOcY2g/CqY/m
         PDk2vMNkQ4ahY3Zxcwy/09oyVzTDqpQF+9naEVyyBC4Nw1EStTUu51e3+Z4bbwiyfg37
         4drltW0M94qkcbPXbgRH9bQcJ9Yb9djOzYDZbr0pP7/xsSngc4dFng15RaTwqx5/JBmc
         v4lw==
X-Forwarded-Encrypted: i=1; AJvYcCWdhBSyQGuqWA2RHmhcnN/jvuw1ftIOBCAP48lNP6lR8za32R7ryDL/em26AyglGqoNsq/5yBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+5hJtqsx5w3VWaKbRjp7BLUeflAaDsW45/paBV9paJCLgcXR
	S+0KWnZmJI6AdvbxMSbwgVVpKwGNzGpkhvAvmpvAXslnsibtWSpm
X-Gm-Gg: ASbGncsqMtxuAItCHz13RaP8YQus1lmX7sVklZ28326QxkgdWnzenjpwTem1wjcJA0w
	Q0z1SgvJDn3dlATdef+svlFdjM5Z2MCh4NinmYDCHeXc2MGXVK5Jfq8Y1XYf8GZbrXfyM/Lrqaz
	9M+gYi8jjw0IM4p52B6T7Q444ID25STalhx7uXXBKCl+nbuUF0LZYDCtqDESu2qjlW1x0GOQgWj
	Du7Qj9pyczl04vXfOguJQy6CRbe3uMr56qW6+A=
X-Google-Smtp-Source: AGHT+IFNVpsQ1SxgOSnHd33anSgu6aiz17MyLpFc8p6+DpYLWnZrtfyreqldKyWeF3yaVqCFlO8jBQ==
X-Received: by 2002:a5d:5988:0:b0:385:de67:229e with SMTP id ffacd0b85a97d-385fd40b038mr865356f8f.11.1733232991536;
        Tue, 03 Dec 2024 05:36:31 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e9c075e8sm8949158f8f.7.2024.12.03.05.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:36:30 -0800 (PST)
Date: Tue, 3 Dec 2024 15:36:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v7 3/9] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241203133628.lcefexgtwvbgasav@skbuf>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-3-ed22e38e6c65@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-packing-pack-fields-and-ice-implementation-v7-3-ed22e38e6c65@intel.com>

On Mon, Dec 02, 2024 at 04:26:26PM -0800, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This is new API which caters to the following requirements:
> 
> - Pack or unpack a large number of fields to/from a buffer with a small
>   code footprint. The current alternative is to open-code a large number
>   of calls to pack() and unpack(), or to use packing() to reduce that
>   number to half. But packing() is not const-correct.
> 
> - Use unpacked numbers stored in variables smaller than u64. This
>   reduces the rodata footprint of the stored field arrays.
> 
> - Perform error checking at compile time, rather than runtime, and return
>   void from the API functions. Because the C preprocessor can't generate
>   variable length code (loops), this is a bit tricky to do with macros.
> 
>   To handle this, implement macros which sanity check the packed field
>   definitions based on their size. Finally, a single macro with a chain of
>   __builtin_choose_expr() is used to select the appropriate macros. We
>   enforce the use of ascending or descending order to avoid O(N^2) scaling
>   when checking for overlap. Note that the macros are written with care to
>   ensure that the compilers can correctly evaluate the resulting code at
>   compile time. In particular, the expressions for the pbuflen and the
>   ordering check are passed all the way down via macros. Earlier versions
>   attempted to use statement expressions with local variables, but not all
>   compilers were able to fully analyze these at compile time, resulting in
>   BUILD_BUG_ON failures.
> 
>   The overlap macro is passed a condition determining whether the fields
>   are expected to be in ascending or descending order based on the relative
>   ordering of the first two fields. This allows users to keep the fields in
>   whichever order is most natural for their hardware, while still keeping
>   the overlap checks scaling to O(N).
> 
>   This method also enables calling CHECK_PACKED_FIELDS directly from within
>   the pack_fields and unpack_fields macros, ensuring all drivers using this
>   API will receive type checking, without needing to remember to call the
>   CHECK_PACKED_FIELDS macro themselves.
> 
> - Reduced rodata footprint for the storage of the packed field arrays.
>   To that end, we have struct packed_field_s (small) and packed_field_m
>   (medium). More can be added as needed (unlikely for now). On these
>   types, the same generic pack_fields() and unpack_fields() API can be
>   used, thanks to the new C11 _Generic() selection feature, which can
>   call pack_fields_s() or pack_fields_m(), depending on the type of the
>   "fields" array - a simplistic form of polymorphism. It is evaluated at
>   compile time which function will actually be called.
> 
> Over time, packing() is expected to be completely replaced either with
> pack() or with pack_fields().
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  Makefile                           |    4 +
>  include/linux/packing.h            |   37 +
>  include/linux/packing_types.h      | 2831 ++++++++++++++++++++++++++++++++++++
>  lib/packing.c                      |  145 ++
>  lib/packing_test.c                 |   61 +
>  scripts/gen_packed_field_checks.c  |   38 +
>  Documentation/core-api/packing.rst |   58 +
>  MAINTAINERS                        |    2 +
>  scripts/Makefile                   |    2 +-
>  9 files changed, 3177 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 8129de0b214f5b73a3b1cca0798041d74270836b..58496942a7d13c6a53e4210d83deb2cc2033d00a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1315,6 +1315,10 @@ PHONY += scripts_unifdef
>  scripts_unifdef: scripts_basic
>  	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
>  
> +PHONY += scripts_gen_packed_field_checks
> +scripts_gen_packed_field_checks: scripts_basic
> +	$(Q)$(MAKE) $(build)=scripts scripts/gen_packed_field_checks
> +
>  # ---------------------------------------------------------------------------
>  # Install
>  
> diff --git a/include/linux/packing.h b/include/linux/packing.h
> index 5d36dcd06f60420325473dae3a0e9ac37d03da4b..f9bfb20060300e33a455b46d3266ea5083a62102 100644
> --- a/include/linux/packing.h
> +++ b/include/linux/packing.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/bitops.h>
> +#include <linux/packing_types.h>

I'm unsure of the benefit of splitting the headers in this way, if
packing_types.h is not going to contain purely auto-generated code and
is tracked fully by git.

> diff --git a/lib/packing.c b/lib/packing.c
> index 09a2d195b9433b61c86f3b63ff019ab319c83e97..45164f73fe5bf9f2c547eb22016af7e44fed9eb0 100644
> --- a/lib/packing.c
> +++ b/lib/packing.c
> @@ -5,10 +5,37 @@
>  #include <linux/packing.h>
>  #include <linux/module.h>
>  #include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/bitrev.h>
>  
> +#define __pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks)	\
> +	({									\
> +		for (size_t i = 0; i < (num_fields); i++) {			\
> +			typeof(&(fields)[0]) field = &(fields)[i];		\
> +			u64 uval;						\
> +										\
> +			uval = ustruct_field_to_u64(ustruct, field->offset, field->size); \
> +										\
> +			__pack(pbuf, uval, field->startbit, field->endbit,	\
> +			       pbuflen, quirks);				\
> +		}								\
> +	})
> +
> +#define __unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks)	\
> +	({									\
> +		for (size_t i = 0; i < (num_fields); i++) {			\
> +			typeof(&(fields)[0]) field = &fields[i];		\
> +			u64 uval;						\
> +										\
> +			__unpack(pbuf, &uval, field->startbit, field->endbit,	\
> +				 pbuflen, quirks);				\
> +										\
> +			u64_to_ustruct_field(ustruct, field->offset, field->size, uval); \
> +		}								\
> +	})
> +
>  /**
>   * calculate_box_addr - Determine physical location of byte in buffer
>   * @box: Index of byte within buffer seen as a logical big-endian big number
> @@ -322,4 +349,122 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
>  }
>  EXPORT_SYMBOL(packing);
>  
> +static u64 ustruct_field_to_u64(const void *ustruct, size_t field_offset,
> +				size_t field_size)
> +{
> +	switch (field_size) {
> +	case 1:
> +		return *((u8 *)(ustruct + field_offset));
> +	case 2:
> +		return *((u16 *)(ustruct + field_offset));
> +	case 4:
> +		return *((u32 *)(ustruct + field_offset));
> +	default:
> +		return *((u64 *)(ustruct + field_offset));
> +	}
> +}
> +
> +static void u64_to_ustruct_field(void *ustruct, size_t field_offset,
> +				 size_t field_size, u64 uval)
> +{
> +	switch (field_size) {
> +	case 1:
> +		*((u8 *)(ustruct + field_offset)) = uval;
> +		break;
> +	case 2:
> +		*((u16 *)(ustruct + field_offset)) = uval;
> +		break;
> +	case 4:
> +		*((u32 *)(ustruct + field_offset)) = uval;
> +		break;
> +	default:
> +		*((u64 *)(ustruct + field_offset)) = uval;
> +		break;
> +	}
> +}
> +
> +/**
> + * pack_fields_s - Pack array of small fields
> + *
> + * @pbuf: Pointer to a buffer holding the packed value.
> + * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
> + * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
> + *	     It is expected (but not checked) that this has the same data type
> + *	     as all struct packed_field_s definitions.
> + * @fields: Array of small packed fields definition. They must not overlap.
> + * @num_fields: Length of @fields array.
> + * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
> + *	    QUIRK_MSB_ON_THE_RIGHT.
> + */
> +void pack_fields_s(void *pbuf, size_t pbuflen, const void *ustruct,
> +		   const struct packed_field_s *fields, size_t num_fields,
> +		   u8 quirks)
> +{
> +	__pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
> +}
> +EXPORT_SYMBOL(pack_fields_s);
> +
> +/**
> + * pack_fields_m - Pack array of medium fields
> + *
> + * @pbuf: Pointer to a buffer holding the packed value.
> + * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
> + * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
> + *	     It is expected (but not checked) that this has the same data type
> + *	     as all struct packed_field_s definitions.
> + * @fields: Array of medium packed fields definition. They must not overlap.
> + * @num_fields: Length of @fields array.
> + * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
> + *	    QUIRK_MSB_ON_THE_RIGHT.
> + */
> +void pack_fields_m(void *pbuf, size_t pbuflen, const void *ustruct,
> +		   const struct packed_field_m *fields, size_t num_fields,
> +		   u8 quirks)
> +{
> +	__pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
> +}
> +EXPORT_SYMBOL(pack_fields_m);
> +
> +/**
> + * unpack_fields_s - Unpack array of small fields
> + *
> + * @pbuf: Pointer to a buffer holding the packed value.
> + * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
> + * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
> + *	     It is expected (but not checked) that this has the same data type
> + *	     as all struct packed_field_s definitions.
> + * @fields: Array of small packed fields definition. They must not overlap.
> + * @num_fields: Length of @fields array.
> + * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
> + *	    QUIRK_MSB_ON_THE_RIGHT.
> + */
> +void unpack_fields_s(const void *pbuf, size_t pbuflen, void *ustruct,
> +		     const struct packed_field_s *fields, size_t num_fields,
> +		     u8 quirks)
> +{
> +	__unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
> +}
> +EXPORT_SYMBOL(unpack_fields_s);
> +
> +/**
> + * unpack_fields_m - Unpack array of medium fields
> + *
> + * @pbuf: Pointer to a buffer holding the packed value.
> + * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
> + * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
> + *	     It is expected (but not checked) that this has the same data type
> + *	     as all struct packed_field_s definitions.
> + * @fields: Array of medium packed fields definition. They must not overlap.
> + * @num_fields: Length of @fields array.
> + * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
> + *	    QUIRK_MSB_ON_THE_RIGHT.
> + */
> +void unpack_fields_m(const void *pbuf, size_t pbuflen, void *ustruct,
> +		     const struct packed_field_m *fields, size_t num_fields,
> +		     u8 quirks)
> +{
> +	__unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
> +}
> +EXPORT_SYMBOL(unpack_fields_m);
> +
>  MODULE_DESCRIPTION("Generic bitfield packing and unpacking");
> diff --git a/lib/packing_test.c b/lib/packing_test.c
> index b38ea43c03fd83639f18a6f3e2a42eae36118c45..3b4167ce56bf65fa4d66cb55d3215aecc33f64c4 100644
> --- a/lib/packing_test.c
> +++ b/lib/packing_test.c
> @@ -396,9 +396,70 @@ static void packing_test_unpack(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, uval, params->uval);
>  }
>  
> +#define PACKED_BUF_SIZE 8
> +
> +typedef struct __packed { u8 buf[PACKED_BUF_SIZE]; } packed_buf_t;
> +
> +struct test_data {
> +	u32 field3;
> +	u16 field2;
> +	u16 field4;
> +	u16 field6;
> +	u8 field1;
> +	u8 field5;
> +};
> +
> +static const struct packed_field_s test_fields[] = {
> +	PACKED_FIELD(63, 61, struct test_data, field1),
> +	PACKED_FIELD(60, 52, struct test_data, field2),
> +	PACKED_FIELD(51, 28, struct test_data, field3),
> +	PACKED_FIELD(27, 14, struct test_data, field4),
> +	PACKED_FIELD(13, 9, struct test_data, field5),
> +	PACKED_FIELD(8, 0, struct test_data, field6),
> +};
> +
> +static void packing_test_pack_fields(struct kunit *test)
> +{
> +	const struct test_data data = {
> +		.field1 = 0x2,
> +		.field2 = 0x100,
> +		.field3 = 0xF00050,
> +		.field4 = 0x7D3,
> +		.field5 = 0x9,
> +		.field6 = 0x10B,
> +	};
> +	packed_buf_t expect = {
> +		.buf = { 0x50, 0x0F, 0x00, 0x05, 0x01, 0xF4, 0xD3, 0x0B },
> +	};
> +	packed_buf_t buf = {};
> +
> +	pack_fields(&buf, sizeof(buf), &data, test_fields, 0);
> +
> +	KUNIT_EXPECT_MEMEQ(test, &expect, &buf, sizeof(buf));
> +}
> +
> +static void packing_test_unpack_fields(struct kunit *test)
> +{
> +	const packed_buf_t buf = {
> +		.buf = { 0x17, 0x28, 0x10, 0x19, 0x3D, 0xA9, 0x07, 0x9C },
> +	};
> +	struct test_data data = {};
> +
> +	unpack_fields(&buf, sizeof(buf), &data, test_fields, 0);
> +
> +	KUNIT_EXPECT_EQ(test, 0, data.field1);
> +	KUNIT_EXPECT_EQ(test, 0x172, data.field2);
> +	KUNIT_EXPECT_EQ(test, 0x810193, data.field3);
> +	KUNIT_EXPECT_EQ(test, 0x36A4, data.field4);
> +	KUNIT_EXPECT_EQ(test, 0x3, data.field5);
> +	KUNIT_EXPECT_EQ(test, 0x19C, data.field6);
> +}
> +
>  static struct kunit_case packing_test_cases[] = {
>  	KUNIT_CASE_PARAM(packing_test_pack, packing_gen_params),
>  	KUNIT_CASE_PARAM(packing_test_unpack, packing_gen_params),
> +	KUNIT_CASE(packing_test_pack_fields),
> +	KUNIT_CASE(packing_test_unpack_fields),
>  	{},
>  };
>  
> diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..09a21afd640bdf37ad5ee9f6cfa1d4b9113efbcd
> --- /dev/null
> +++ b/scripts/gen_packed_field_checks.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2024, Intel Corporation
> +#include <stdbool.h>
> +#include <stdio.h>
> +
> +#define MAX_PACKED_FIELD_SIZE 50
> +
> +int main(int argc, char **argv)
> +{
> +	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
> +		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);
> +		printf("\ttypeof(&(fields)[0]) _f = (fields); \\\n");
> +		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
> +
> +		for (int j = 0; j < i; j++)
> +			printf("\tCHECK_PACKED_FIELD(_f[%d]); \\\n", j);
> +
> +		for (int j = 1; j < i; j++)
> +			printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[%d], _f[%d]); \\\n",
> +			       j - 1, j);
> +
> +		printf("})\n\n");
> +	}
> +
> +	printf("#define CHECK_PACKED_FIELDS(fields) \\\n");
> +
> +	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++)
> +		printf("\t__builtin_choose_expr(ARRAY_SIZE(fields) == %d, CHECK_PACKED_FIELDS_%d(fields), \\\n",
> +		       i, i);
> +
> +	printf("\t({ BUILD_BUG_ON_MSG(1, \"CHECK_PACKED_FIELDS() must be regenerated to support array sizes larger than %d.\"); }) \\\n",
> +	       MAX_PACKED_FIELD_SIZE);
> +
> +	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++)
> +		printf(")");
> +
> +	printf("\n");
> +}
> diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
> index 821691f23c541cee27995bb1d77e23ff04f82433..5f729a9d4e87b438b67ec6b46626403c8f1655c3 100644
> --- a/Documentation/core-api/packing.rst
> +++ b/Documentation/core-api/packing.rst
> @@ -235,3 +235,61 @@ programmer against incorrect API use.  The errors are not expected to occur
>  during runtime, therefore it is reasonable for xxx_packing() to return void
>  and simply swallow those errors. Optionally it can dump stack or print the
>  error description.
> +
> +The pack_fields() and unpack_fields() macros automatically select the
> +appropriate function at compile time based on the type of the fields array
> +passed in.

This paragraph is out of context (select the appropriate function among
which options? what fields array?).

May I suggest the following documentation addition instead?

Intended use
------------

Drivers that opt to use this API first need to identify which of the above 3
quirk combinations (for a total of 8) match what the hardware documentation
describes.

There are 3 supported usage patterns, detailed below.

packing()
^^^^^^^^^

This API function is deprecated.

The packing() function returns an int-encoded error code, which protects the
programmer against incorrect API use.  The errors are not expected to occur
during runtime, therefore it is reasonable to wrap packing() into a custom
function which returns void and simply swallow those errors. Optionally it can
dump stack or print the error description.

.. code-block:: c

  void my_packing(void *buf, u64 *val, int startbit, int endbit,
                  size_t len, enum packing_op op)
  {
          int err;

          /* Adjust quirks accordingly */
          err = packing(buf, val, startbit, endbit, len, op, QUIRK_LSW32_IS_FIRST);
          if (likely(!err))
                  return;

          if (err == -EINVAL) {
                  pr_err("Start bit (%d) expected to be larger than end (%d)\n",
                         startbit, endbit);
          } else if (err == -ERANGE) {
                  if ((startbit - endbit + 1) > 64)
                          pr_err("Field %d-%d too large for 64 bits!\n",
                                 startbit, endbit);
                  else
                          pr_err("Cannot store %llx inside bits %d-%d (would truncate)\n",
                                 *val, startbit, endbit);
          }
          dump_stack();
  }

pack() and unpack()
^^^^^^^^^^^^^^^^^^^

These are const-correct variants of packing(), and eliminate the last "enum
packing_op op" argument.

Calling pack(...) is equivalent, and preferred, to calling packing(..., PACK).

Calling unpack(...) is equivalent, and preferred, to calling packing(..., UNPACK).

pack_fields() and unpack_fields()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The library exposes optimized functions for the scenario where there are many
fields represented in a buffer, and it encourages consumer drivers to avoid
repetitive calls to pack() and unpack() for each field, but instead use
pack_fields() and unpack_fields(), which reduces the code footprint.

These APIs use field definitions in arrays of ``struct packed_field_s`` (small)
or ``struct packed_field_m`` (medium), allowing consumer drivers to minimize
the size of these arrays according to their custom requirements.

The pack_fields() and unpack_fields() API functions are actually macros which
automatically select the appropriate function at compile time, based on the
type of the fields array passed in.

An additional benefit over pack() and unpack() is that sanity checks on the
field definitions are handled at compile time with ``BUILD_BUG_ON`` rather
than only when the offending code is executed. These functions return void and
wrapping them to handle unexpected errors is not necessary.

It is recommended, but not required, that you wrap your packed buffer into a
structured type with a fixed size. This generally makes it easier for the
compiler to enforce that the correct size buffer is used.

Here is an example of how to use the fields APIs:

.. code-block:: c

   /* Ordering inside the unpacked structure is flexible and can be different
    * from the packed buffer. Here, it is optimized to reduce padding.
    */
   struct data {
        u64 field3;
        u32 field4;
        u16 field1;
        u8 field2;
   };

   #define SIZE 13

   typdef struct __packed { u8 buf[SIZE]; } packed_buf_t;

   static const struct packed_field_s fields[] = {
           PACKED_FIELD(100, 90, struct data, field1),
           PACKED_FIELD(90, 87, struct data, field2),
           PACKED_FIELD(86, 30, struct data, field3),
           PACKED_FIELD(29, 0, struct data, field4),
   };

   void unpack_your_data(const packed_buf_t *buf, struct data *unpacked)
   {
           BUILD_BUG_ON(sizeof(*buf) != SIZE;

           unpack_fields(buf, sizeof(*buf), unpacked, fields,
                         QUIRK_LITTLE_ENDIAN);
   }

   void pack_your_data(const struct data *unpacked, packed_buf_t *buf)
   {
           BUILD_BUG_ON(sizeof(*buf) != SIZE;

           pack_fields(buf, sizeof(*buf), unpacked, fields,
                       QUIRK_LITTLE_ENDIAN);
   }


Also, I think this patch could use some de-cluttering by making the
documentation update separate. We need to document 2 new APIs anyway,
not just pack_fields() but also pack().

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0456a33ef65792bacb5d305a6384d245844fb743..7ef0abcb58c8a42e60222f6fc85df44602c360d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17559,8 +17559,10 @@ L:	netdev@vger.kernel.org
>  S:	Supported
>  F:	Documentation/core-api/packing.rst
>  F:	include/linux/packing.h
> +F:	include/linux/packing_types.h
>  F:	lib/packing.c
>  F:	lib/packing_test.c
> +F:	scripts/gen_packed_field_checks.c
>  
>  PADATA PARALLEL EXECUTION MECHANISM
>  M:	Steffen Klassert <steffen.klassert@secunet.com>
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 6bcda4b9d054021b185488841cd36c6e0fb86d0c..546e8175e1c4c8209e67a7f92f7d1e795a030988 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -47,7 +47,7 @@ HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
>  endif
>  
>  # The following programs are only built on demand
> -hostprogs += unifdef
> +hostprogs += unifdef gen_packed_field_checks

I will let those who have been more vocal in their complaints about
the compile-time checks comment on whether this approach of running
gen_packed_field_checks on demand rather than during any build is
acceptable.

>  
>  # The module linker script is preprocessed on demand
>  targets += module.lds
> 
> -- 
> 2.47.0.265.g4ca455297942
> 

