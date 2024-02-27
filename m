Return-Path: <netdev+bounces-75267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411DA868DF2
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615851C2388C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD211386AC;
	Tue, 27 Feb 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz1nr0NR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE6138480
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031003; cv=none; b=NZGwUbVteypx1dfnOTnTQZnwv0isAYX8AAVfiFY+PNguHlPp9jFWiMXh8uLdXLLNpKVcWJIDOlxWwHjpnTPu1yOT8PgUXTvkjC0QvaOzi5BekEPvHjCTVCePTWBd+BukgffgcsWbJOWiXf3qCV1bfY1O5lFG94t8+TdjXz6SDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031003; c=relaxed/simple;
	bh=ToNavMFCmv9S8DGyc1brmadFn2GxTiWYVfSPQPinN1o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=EiA18xh/QxqRn+eeYa/xs7J/Du/l3RirWwI7CzTQ7JvWpyEJ1zUB4HaDUpBooCm3wzbhntIQOkeuhs0u77wFdhMlYgd1Ywg5Gj15lchZgJ0irqgG+E6zIEjRKkBakcGOySaDcjF2tuBIuc/cgxCm+QXlfawYx3+1V561PjfCN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz1nr0NR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412ad940fe8so2994295e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 02:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709031000; x=1709635800; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qyzisckoqCf9UVSfnKhjFL+FCU4QcCzR6e4BMsGN3k=;
        b=Uz1nr0NRNWj17or+NOfUnqrUl/NIpu9MyTu/GPr6tkYodYq8RSVtOEoxDhgSVXJjXx
         W+nVgoygcCxlmrv4SYhEMpgjk6/k0QyIZZG6+OoThhYSqBJr0EXmveSa9bOpHHnnEJYN
         Tpfd4eP0oYDmdKvrM6AJx3cQ47+Hfi1uNOKNAHjjyj8vJc6CVzGEyFZ21x9StSkWMbiH
         0JJ29iVQWvAPwDO4M6DI11JRbxMczoy12wx0lAKTPIOmiFBiMh1SxxOtFL2gjiCHcF6Z
         yv7DxKVo1Nr31qscFRLuoYtRm0NgMRY1k83QkpYViUpxv3gZlx9QTuZr5Y5oKKYuCV7i
         ErQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031000; x=1709635800;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qyzisckoqCf9UVSfnKhjFL+FCU4QcCzR6e4BMsGN3k=;
        b=vhGpiK6zNQ4qGCvD3QAbZdaF6lYJMXT1x0TJOfPHRx3+5qmgwX6Y6tL960Gov5sdwS
         UhwlHv3dVPOsNlN3CVtMyX180Ibc845QW6NppnohNk18ebRaTX87U3DXwDHixY+oYXCJ
         LoTH9CKWI1ACiQFQXzho+eS0qloN0qW5prRqpPDY5hJmSXPmnIeltXwftzUQa5OmKnNg
         dJgF2/2F3xHQ35NtxphcfSmrIdD8TAk1ygQo4zRoMDNe5nwX9FytqnjIfnp0/1XjSYXn
         yfe0n8KHvohTWNjQIBO2wq9gEhKzHXaARUrUTBhmZOFNaITh78VtWnvER0+AZb8MXebU
         DbOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZO1SmbzEHCJXR07Kg7fD2KkCYcdczPht8cpoQ7SyIjJf4P5qGgDblGktIdC2hZBjTGiy/OQhrt1LaRibvvsr6rnwF6Aku
X-Gm-Message-State: AOJu0YwiVqIy7pFz8HUCdJsThcZXTuGu1OEyBmb2rjMP0lXNnXKr9PiX
	u34Ab7WRRn9SIvFUVGJpjS7XW2BtwZWWzLQuswxae7HhW/7OhFsD
X-Google-Smtp-Source: AGHT+IEbDtzUtq+AFcgOmqc1TCpVld5XF1Fpq7FNCYKraCeVSa+ma1WFsr1u+6GXYUaoy7vClex1IQ==
X-Received: by 2002:a05:6000:71b:b0:33d:c652:7c45 with SMTP id bs27-20020a056000071b00b0033dc6527c45mr6869283wrb.34.1709030999519;
        Tue, 27 Feb 2024 02:49:59 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:58f7:fdc0:53dd:c2b2])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600016c400b0033dda0e82e5sm5657901wrf.32.2024.02.27.02.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 02:49:58 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us,  sdf@google.com,
  nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 00/15] tools: ynl: stop using libmnl
In-Reply-To: <20240226100020.2aa27e8f@kernel.org> (Jakub Kicinski's message of
	"Mon, 26 Feb 2024 10:00:20 -0800")
Date: Tue, 27 Feb 2024 10:49:42 +0000
Message-ID: <m2ttlumbax.fsf@gmail.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com>
	<20240223083440.0793cd46@kernel.org> <m27ciroaur.fsf@gmail.com>
	<20240226100020.2aa27e8f@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 26 Feb 2024 09:04:12 +0000 Donald Hunter wrote:
>> > On Fri, 23 Feb 2024 16:26:33 +0000 Donald Hunter wrote:  
>> >> Is the absence of buffer bounds checking intentional, i.e. relying on libasan?  
>> >
>> > In ynl.c or the generated code?  
>> 
>> I'm looking at ynl_attr_nest_start() and ynl_attr_put*() in ynl-priv.h
>> and there's no checks for buffer overrun. It is admittedly a big
>> buffer, with rx following tx, but still.
>
> You're right. But this series isn't making it worse, AFAIU.
> We weren't checking before, we aren't checking now.

Agreed, libmnl had the same issue.

> I don't want to have to add another arg to all put() calls.
> How about we sash the max len on nlmsg_pid?

Seems reasonable. Minor comments below.

> Something like:
>
> diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
> index 6361318e5c4c..d4ffe18b00f9 100644
> --- a/tools/net/ynl/lib/ynl-priv.h
> +++ b/tools/net/ynl/lib/ynl-priv.h
> @@ -135,6 +135,8 @@ int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
>  
>  /* Netlink message handling helpers */
>  
> +#define YNL_MSG_OVERFLOW	1
> +
>  static inline struct nlmsghdr *ynl_nlmsg_put_header(void *buf)
>  {
>  	struct nlmsghdr *nlh = buf;
> @@ -239,11 +241,26 @@ ynl_attr_first(const void *start, size_t len, size_t skip)
>  	return ynl_attr_if_good(start + len, attr);
>  }
>  
> +static inline bool
> +__ynl_attr_put_overflow(struct nlmsghdr *nlh, size_t size)
> +{
> +	bool o;
> +
> +	/* We stash buffer length on nlmsg_pid. */
> +	o = nlh->nlmsg_len + NLA_HDRLEN + NLMSG_ALIGN(size) > nlh->nlmsg_pid;

The comment confused me here. How about "We compare against stashed buffer
length in nlmsg_pid".

> +	if (o)
> +		nlh->nlmsg_pid = YNL_MSG_OVERFLOW;

It took me a moment to realise that this behaves like a very short
buffer length for subsequent calls to __ynl_attr_put_overflow(). Is it
worth extending the comment in ynl_msg_start() to say "buffer length or
overflow status"?

> +	return o;
> +}
> +
>  static inline struct nlattr *
>  ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
>  {
>  	struct nlattr *attr;
>  
> +	if (__ynl_attr_put_overflow(nlh, 0))
> +		return ynl_nlmsg_end_addr(nlh) - NLA_HDRLEN;

Is the idea here to return a struct nlattr * that is safe to use?
Shouldn't we zero the values in the buffer first?

> +
>  	attr = ynl_nlmsg_end_addr(nlh);
>  	attr->nla_type = attr_type | NLA_F_NESTED;
>  	nlh->nlmsg_len += NLMSG_ALIGN(sizeof(struct nlattr));
> @@ -263,6 +280,9 @@ ynl_attr_put(struct nlmsghdr *nlh, unsigned int attr_type,
>  {
>  	struct nlattr *attr;
>  
> +	if (__ynl_attr_put_overflow(nlh, size))
> +		return;
> +
>  	attr = ynl_nlmsg_end_addr(nlh);
>  	attr->nla_type = attr_type;
>  	attr->nla_len = NLA_HDRLEN + size;
> @@ -276,14 +296,17 @@ static inline void
>  ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
>  {
>  	struct nlattr *attr;
> -	const char *end;
> +	size_t len;
> +
> +	len = strlen(str);
> +	if (__ynl_attr_put_overflow(nlh, len))
> +		return;
>  
>  	attr = ynl_nlmsg_end_addr(nlh);
>  	attr->nla_type = attr_type;
>  
> -	end = stpcpy(ynl_attr_data(attr), str);
> -	attr->nla_len =
> -		NLA_HDRLEN + NLA_ALIGN(end - (char *)ynl_attr_data(attr));
> +	strcpy(ynl_attr_data(attr), str);
> +	attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
>  
>  	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
>  }
> diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
> index 86729119e1ef..c2ba72f68028 100644
> --- a/tools/net/ynl/lib/ynl.c
> +++ b/tools/net/ynl/lib/ynl.c
> @@ -404,9 +404,33 @@ struct nlmsghdr *ynl_msg_start(struct ynl_sock *ys, __u32 id, __u16 flags)
>  	nlh->nlmsg_flags = flags;
>  	nlh->nlmsg_seq = ++ys->seq;
>  
> +	/* This is a local YNL hack for length checking, we put the buffer
> +	 * length in nlmsg_pid, since messages sent to the kernel always use
> +	 * PID 0. Message needs to be terminated with ynl_msg_end().
> +	 */
> +	nlh->nlmsg_pid = YNL_SOCKET_BUFFER_SIZE;
> +
>  	return nlh;
>  }
>  
> +static int ynl_msg_end(struct ynl_sock *ys, struct nlmsghdr *nlh)
> +{
> +	/* We stash buffer length on nlmsg_pid */
> +	if (nlh->nlmsg_pid == 0) {
> +		yerr(ys, YNL_ERROR_INPUT_INVALID,
> +		     "Unknwon input buffer lenght");

Typo: lenght -> length

> +		return -EINVAL;
> +	}
> +	if (nlh->nlmsg_pid == YNL_MSG_OVERFLOW) {
> +		yerr(ys, YNL_ERROR_INPUT_TOO_BIG,
> +		     "Constructred message longer than internal buffer");
> +		return -EMSGSIZE;
> +	}
> +
> +	nlh->nlmsg_pid = 0;
> +	return 0;
> +}
> +
>  struct nlmsghdr *
>  ynl_gemsg_start(struct ynl_sock *ys, __u32 id, __u16 flags,
>  		__u8 cmd, __u8 version)
> @@ -606,6 +630,10 @@ static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
>  	nlh = ynl_gemsg_start_req(ys, GENL_ID_CTRL, CTRL_CMD_GETFAMILY, 1);
>  	ynl_attr_put_str(nlh, CTRL_ATTR_FAMILY_NAME, family_name);
>  
> +	err = ynl_msg_end(ys, nlh);
> +	if (err < 0)
> +		return err;
> +
>  	err = send(ys->socket, nlh, nlh->nlmsg_len, 0);
>  	if (err < 0) {
>  		perr(ys, "failed to request socket family info");
> @@ -867,6 +895,10 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
>  {
>  	int err;
>  
> +	err = ynl_msg_end(ys, req_nlh);
> +	if (err < 0)
> +		return err;
> +
>  	err = send(ys->socket, req_nlh, req_nlh->nlmsg_len, 0);
>  	if (err < 0)
>  		return err;
> @@ -920,6 +952,10 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
>  {
>  	int err;
>  
> +	err = ynl_msg_end(ys, req_nlh);
> +	if (err < 0)
> +		return err;
> +
>  	err = send(ys->socket, req_nlh, req_nlh->nlmsg_len, 0);
>  	if (err < 0)
>  		return err;
> diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
> index dbeeef8ce91a..9842e85a8c57 100644
> --- a/tools/net/ynl/lib/ynl.h
> +++ b/tools/net/ynl/lib/ynl.h
> @@ -20,6 +20,8 @@ enum ynl_error_code {
>  	YNL_ERROR_ATTR_INVALID,
>  	YNL_ERROR_UNKNOWN_NTF,
>  	YNL_ERROR_INV_RESP,
> +	YNL_ERROR_INPUT_INVALID,
> +	YNL_ERROR_INPUT_TOO_BIG,
>  };
>  
>  /**

