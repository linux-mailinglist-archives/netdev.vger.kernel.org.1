Return-Path: <netdev+bounces-240958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54820C7CCC4
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACDB04E19EF
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CD9286422;
	Sat, 22 Nov 2025 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KULxkexQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C012459F7
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763808552; cv=none; b=bT0icRxYFK/LZIbZOVUdWfYUeqU34YObB+7TpjECP5siEX9Hkyx8RMqgPC5y6qae9v5X4PRMPevpa3/AAVKYr6wwMVZ9pk56Ih4gyeTefdOnpYH9qlP0CroFGSHRdN1XGdReZdEQAPWMmDV0bBL93jrw8l+qNBzDGpYQBa61waM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763808552; c=relaxed/simple;
	bh=TYswH870hXYIzZojFLMU4d7bPmU2mTLiVm3ZOrZEML4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su77bH8e+S3Npossjn9AosMORcdYDVMf6Yd/5tv0CN+E3ec3UXNbzas/QGjo00a5m5/KAl5xGtqGvQC9fmioHaJXoG2vvteez5wcF+ixZ9GTHkbUBtCbhq0es+N99bPSzqSLhawrkyccKBVvWYvIVEH4ey7Y1HbPPPhqUoMrtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KULxkexQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736ffc531fso413949466b.1
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 02:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763808548; x=1764413348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0gnSeK29WCUH1isiB8XCY9MtuGLgdRazHelY/B4236A=;
        b=KULxkexQAzfMdqoYwR1YyIupJMmtz9jnQRfWP0S7hJ0HzmuOTg73PjgjPatJqglXHd
         8TyjWQFn7+GvRGOsJSp1SjeEHtADNxegX1GcDCzVm3Mho575/S5dsdFGBpdFxU/44t4s
         ijlLvTNYXHf797YIpC1mdD7c/xvrrIfegIYXGf7zRhzGc4ksHn3b9TeGkMXIP/eSzokc
         E7XxQyZhwb6/vbjFeTMAHqISQHFHoWh2Y5T2Iictn09HKj87u3j27vKeAtyPwMIS+QI+
         axKuRsw7txTwLnz159mu9FBPfgjnoaEvd7wt6LwWw9IEzaFm+aGlJTKnfRvIaIP6B0yD
         5qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808548; x=1764413348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gnSeK29WCUH1isiB8XCY9MtuGLgdRazHelY/B4236A=;
        b=O/Y/xHxc8fAk5gtQj4CCj7TGbm+oSRpzSH1Fmx4JmQEZB5h+LV2IvccG0wYDYDuZgS
         euDCRFtMwkY1pfim1MBmEX0dWyJ9Pj1pVCXMJLlQlv2IYzDxEBZJL2b+GqcvB0K01aeD
         Yme8p8bPUWxpwMgyeDUZlOIPuNOnAmus1JD7OfxR9A2TZ4Zxy0K4RxFNAH7xaCx04OEw
         iUpydgtU/CnkpBg767akjhzZjSAb+OP/jfUpLAb007R8QVrU+KdmTp/AhOVD4VrJhOyy
         sUOlUl6fpX6f/ylTGKqXJFWdo9JEvI3MasK9STOst+YwL9nwUtX8z4z9fllh7FhkN8hu
         j1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWtyiU9bONb0J092jAXNi644H0chE+iEXrZG2FFrUEKQCmUAebbpf5HmueDpyYXpmigk1WhWcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycGcBvjoyLk5i/TZFlm7a1c1ToZ2iISgEJMKCq6i3vQ4ZIx+jX
	lS4ctJwPLha/qlxbaIdmQrYwE3cOwdir+2KPCPAwmpC4wJ7EgCWgySLb
X-Gm-Gg: ASbGncsQNI1taKSBYWU+qinIKzB/i/KGpw0y8BUI08ONkztbSCmY4b6xw38iWZN8PiE
	rN9I7k6EIRDlinpnU15EEZ41R0AYmCEpS+IefqEZmOJlTrO1aGuQ76T66MwwRjlGlJ/m0UkD5K6
	WHJAvDz0weZy2aG8b0CpUH7tS+HgWq0bQfPLG+gX0fOGcBD+qwACiI/YY4rIveCS0wZ3bazqusb
	yNk+wx2Kg0GwR5Cpgz86SiltYF9Pz5pB47McV1/JC98PtqcoSDQVRNuY/3FHfRXz/XF00VnE436
	WvRhECwriyqhZu4PtCLTPYpc4zViQ+Iju7I3o48iAc0GeFCFYI/35KJm/PMhHvvkN/4l5R7MmwG
	BSXf17hpO1FEBOyeiHBSlEzkw6q/8W9YUhiF7v2ACmyZUhi9N2QCatGZOOCKpx5Baf03Q0XixL0
	tBF1EPdXYR8XPSf3BYAHOBXixgSm/AXYbELJjHXY+eormxxs4=
X-Google-Smtp-Source: AGHT+IHEqpb/CHX1L+AE/5T97F41QM9rFCHKz3O7GJJX7312ChR3axS74WXLzxav0V8Ci6ajPzUrGg==
X-Received: by 2002:a17:907:7206:b0:b73:7c3e:e17c with SMTP id a640c23a62f3a-b767170ad29mr674301266b.44.1763808547805;
        Sat, 22 Nov 2025 02:49:07 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7a0f4sm709458066b.26.2025.11.22.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:49:07 -0800 (PST)
Date: Sat, 22 Nov 2025 11:49:05 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, gnoack@google.com, willemdebruijn.kernel@gmail.com,
	matthieu@buffet.re, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	yusongping@huawei.com, artem.kuzin@huawei.com,
	konstantin.meskhidze@huawei.com
Subject: Re: [RFC PATCH v4 01/19] landlock: Support socket access-control
Message-ID: <20251122.e645d2f1b8a1@gnoack.org>
References: <20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com>
 <20251118134639.3314803-2-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118134639.3314803-2-ivanov.mikhail1@huawei-partners.com>

Hello!

On Tue, Nov 18, 2025 at 09:46:21PM +0800, Mikhail Ivanov wrote:
> It is possible to create sockets of the same protocol with different
> protocol number values. For example, TCP sockets can be created using one
> of the following commands:
>     1. fd = socket(AF_INET, SOCK_STREAM, 0);
>     2. fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> Whereas IPPROTO_TCP = 6. Protocol number 0 correspond to the default
> protocol of the given protocol family and can be mapped to another
> value.
> 
> Socket rules do not perform such mappings to not increase complexity
> of rules definition and their maintenance.

Minor phrasing nit: Maybe we can phrase this constructively, like
"rules operate on the socket(2) parameters as they are passed by the
user, before this mapping happens"?


> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f030adc462ee..030c96cb5d25 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -45,6 +45,11 @@ struct landlock_ruleset_attr {
>  	 * flags`_).
>  	 */
>  	__u64 handled_access_net;
> +	/**
> +	 * @handled_access_socket: Bitmask of handled actions performed on sockets
> +	 * (cf. `Socket flags`).
> +	 */
> +	__u64 handled_access_socket;

This struct can only be extended at the end, for ABI compatibility reasons.

In the call to landlock_create_ruleset(2), the user passes the __user
pointer to this struct along with its size (as known to the user at
compile time).  When we copy this into the kernel, we blank out the
struct and only copy the prefix of the caller-supplied size.  The
implementation is in copy_min_struct_from_user() in landlock/syscalls.c.

When you rearrange the order, please also update it in other places
where these fields are mentioned next to each other, for
consistency. I'll try to point it out where I see it in the review,
but I might miss some places.

>  	/**
>  	 * @scoped: Bitmask of scopes (cf. `Scope flags`_)
>  	 * restricting a Landlock domain from accessing outside
> @@ -140,6 +145,11 @@ enum landlock_rule_type {
>  	 * landlock_net_port_attr .
>  	 */
>  	LANDLOCK_RULE_NET_PORT,
> +	/**
> +	 * @LANDLOCK_RULE_SOCKET: Type of a &struct
> +	 * landlock_socket_attr.
                               ^

Nit: Adjacent documentation has a space before the dot.
I assume this is needed for kernel doc formatting?

> +	 */
> +	LANDLOCK_RULE_SOCKET,
>  };
>  
>  /**
> @@ -191,6 +201,33 @@ struct landlock_net_port_attr {
>  	__u64 port;
>  };
>  
> +/**
> + * struct landlock_socket_attr - Socket protocol definition
> + *
> + * Argument of sys_landlock_add_rule().
> + */
> +struct landlock_socket_attr {
> +	/**
> +	 * @allowed_access: Bitmask of allowed access for a socket protocol
> +	 * (cf. `Socket flags`_).
> +	 */
> +	__u64 allowed_access;
> +	/**
> +	 * @family: Protocol family used for communication
> +	 * (cf. include/linux/socket.h).
> +	 */
> +	__s32 family;
> +	/**
> +	 * @type: Socket type (cf. include/linux/net.h)
> +	 */
> +	__s32 type;
> +	/**
> +	 * @protocol: Communication protocol specific to protocol family set in
> +	 * @family field.

This is specific to both the @family and the @type, not just the @family.

From socket(2):

  Normally only a single protocol exists to support a particular
  socket type within a given protocol family.

For instance, in your commit message above the protocol in the example
is IPPROTO_TCP, which would imply the type SOCK_STREAM, but not work
with SOCK_DGRAM.

> +	 */
> +	__s32 protocol;
> +} __attribute__((packed));

Since we are in the UAPI header, please also document the wildcard
values for @type and @protocol.

(Remark, should those be exposed as constants?)


> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 7961c6630a2d..03ccd6fbfe83 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -40,6 +40,8 @@ typedef u16 access_mask_t;
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
>  /* Makes sure all network access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
> +/* Makes sure all socket access rights can be stored. */
> +static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_SOCKET);
>  /* Makes sure all scoped rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
>  /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
> @@ -49,6 +51,7 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  struct access_masks {
>  	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
>  	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> +	access_mask_t socket : LANDLOCK_NUM_ACCESS_SOCKET;
>  	access_mask_t scope : LANDLOCK_NUM_SCOPE;

(Please re-adjust field order for consistency with UAPI)

>  };

> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index dfcdc19ea268..a34d2dbe3954 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -55,15 +56,15 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  	return new_ruleset;
>  }
>  
> -struct landlock_ruleset *
> -landlock_create_ruleset(const access_mask_t fs_access_mask,
> -			const access_mask_t net_access_mask,
> -			const access_mask_t scope_mask)
> +struct landlock_ruleset *landlock_create_ruleset(
> +	const access_mask_t fs_access_mask, const access_mask_t net_access_mask,
> +	const access_mask_t socket_access_mask, const access_mask_t scope_mask)

(Please re-adjust field order for consistency with UAPI)

>  {
>  	struct landlock_ruleset *new_ruleset;
>  
>  	/* Informs about useless ruleset. */
> -	if (!fs_access_mask && !net_access_mask && !scope_mask)
> +	if (!fs_access_mask && !net_access_mask && !socket_access_mask &&
> +	    !scope_mask)

(Please re-adjust field order for consistency with UAPI)

>  		return ERR_PTR(-ENOMSG);
>  	new_ruleset = create_ruleset(1);
>  	if (IS_ERR(new_ruleset))
> @@ -72,6 +73,9 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
>  		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
>  	if (net_access_mask)
>  		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
> +	if (socket_access_mask)
> +		landlock_add_socket_access_mask(new_ruleset, socket_access_mask,
> +						0);

(Please re-adjust order of these "if"s for consistency with UAPI)

>  	if (scope_mask)
>  		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
>  	return new_ruleset;

> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 1a78cba662b2..a60ede2fc2a5 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -189,10 +204,9 @@ struct landlock_ruleset {
>  	};
>  };
>  
> -struct landlock_ruleset *
> -landlock_create_ruleset(const access_mask_t access_mask_fs,
> -			const access_mask_t access_mask_net,
> -			const access_mask_t scope_mask);
> +struct landlock_ruleset *landlock_create_ruleset(
> +	const access_mask_t access_mask_fs, const access_mask_t access_mask_net,
> +	const access_mask_t access_mask_socket, const access_mask_t scope_mask);

(Please re-adjust field order for consistency with UAPI)

> index 000000000000..28a80dcad629
> --- /dev/null
> +++ b/security/landlock/socket.c
> @@ -0,0 +1,105 @@
> [...]
> +#define TYPE_ALL (-1)
> +#define PROTOCOL_ALL (-1)

Should these definitions go into the UAPI header (with a LANDLOCK_ prefix)?


> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 33eafb71e4f3..e9f500f97c86 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -101,9 +104,10 @@ static void build_check_abi(void)
>  	 */
>  	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
>  	ruleset_size += sizeof(ruleset_attr.handled_access_net);
> +	ruleset_size += sizeof(ruleset_attr.handled_access_socket);
>  	ruleset_size += sizeof(ruleset_attr.scoped);
(Please re-adjust field order for consistency with UAPI)

>  	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
> -	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
> +	BUILD_BUG_ON(sizeof(ruleset_attr) != 32);
> [...]

> @@ -237,6 +248,11 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  	    LANDLOCK_MASK_ACCESS_NET)
>  		return -EINVAL;
>  
> +	/* Checks socket content (and 32-bits cast). */
> +	if ((ruleset_attr.handled_access_socket |
> +	     LANDLOCK_MASK_ACCESS_SOCKET) != LANDLOCK_MASK_ACCESS_SOCKET)
> +		return -EINVAL;
> +
>  	/* Checks IPC scoping content (and 32-bits cast). */
>  	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) != LANDLOCK_MASK_SCOPE)
>  		return -EINVAL;
> @@ -244,6 +260,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  	/* Checks arguments and transforms to kernel struct. */
>  	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
>  					  ruleset_attr.handled_access_net,
> +					  ruleset_attr.handled_access_socket,
>  					  ruleset_attr.scoped);

(Please re-adjust field order for consistency with UAPI)

>  	if (IS_ERR(ruleset))
>  		return PTR_ERR(ruleset);
> [...]

> @@ -407,6 +458,8 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>   *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset
>   *   handled accesses)
>   * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
> + * - %EINVAL: &landlock_socket_attr.{family, type} are greater than 254 or
> + *   &landlock_socket_attr.protocol is greater than 65534;

Hmm, this is a bit annoying that these values have such unusual
bounds, even though the input parameters are 32 bit.  We are exposing
a little bit that we are internally storing this with only 8 and 16
bits...  (I don't know a better solution immediately either, though. I
think we discussed this on a previous version of the patch set as well
and ended up with permitting larger values than the narrower SOCK_MAX
etc bounds.)

>   * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access is
>   *   0);
>   * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
> @@ -439,6 +492,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>  		return add_rule_path_beneath(ruleset, rule_attr);
>  	case LANDLOCK_RULE_NET_PORT:
>  		return add_rule_net_port(ruleset, rule_attr);
> +	case LANDLOCK_RULE_SOCKET:
> +		return add_rule_socket(ruleset, rule_attr);
>  	default:
>  		return -EINVAL;
>  	}

–Günther

