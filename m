Return-Path: <netdev+bounces-187844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA31AA9DD2
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 23:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0017F6EC
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73812270548;
	Mon,  5 May 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nfXRPFXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904226F452
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479194; cv=none; b=emB4h3Z6Fup9qGSq6KPYRXo7UN0FU7g/kogGfmHMJfhZXqTkFULs81IArLx0N+xajLUf450pi43S5hDEDrT2IYdozwEAlLORjIny5/JOg4M5hKNeGE4a2pcj+Mkoh1GQoa5aEjNq+I0/H4SDm8i6iI95p8TVZ2d5KUVxAsMQJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479194; c=relaxed/simple;
	bh=5D4UR6yrC02HsfYWF2fnDeI7m9ilUlRIe2YUeXg+vVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlP1dbxAuDW4BPfA2NJPLAj2S4MUVdJip4Dop68Du+6iVBhn5CsT5tW9FaxSFRSfA05uZRkJOJJ9XqztG5e5QqrS5SSQj9X2RP3UfdYGyR5hdMzbeS6pOc4jGDU70ikjv5/BsBP/K2BUJpMwi2klSVnQ71UcIRC/BTuzWnu48Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nfXRPFXL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33ac23edso54266235ad.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746479192; x=1747083992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziwd7DkzqCHv5BZRiJhdQnxG6MiqU3QIW7cbJEJQApk=;
        b=nfXRPFXLdkdovcgyGrIqxmdfcYGM9UEd7hUjOa3Z2WmS16Lp9gHGclD/wLw0IFQ72N
         hnSaubE3Z7z2AfWBx+qRlQSvvBc3Z1NHocn41l535kFUR2FYlaByWG56ln48Xv6KeXDy
         dE/uTZZAv8+6kSg2hGEJS0N1DWk5TvEkc0qLvwNoOMyyY5rhBdw4pPRLXUt4w81KT4Pw
         o1k0YBCAMb30H856WfYvZwHN45ayw8KivhXGCdulT2IvftCbUfqWq9QWywrl2FcVhyTd
         tHG06CoQA4F8Ts9829BR4pzL0xH5KC3i9HFqLhHd+8jFn7Bs7vLM2NJhirIkOfcxfRnC
         zqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746479192; x=1747083992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziwd7DkzqCHv5BZRiJhdQnxG6MiqU3QIW7cbJEJQApk=;
        b=eLCexqfPY+HboNev5kOwfJ3EoIMyUVoIRiTlHx330BObqeqvW7TM6iKHlpqAV5EH/w
         aPA+kZXtDvonFMQleUh0lwMGKKyV5pjTuxnApwf4xLVy02rccH1quICYMlfMQ+wm/tkx
         Gs5d+MvWr/YkoSxhxUexz//YPgPF4VeLFTcbzA8POt58N1h68NStW8XU/PwgzVE6WbfM
         nJCmB/twltRst+lkc4XeZKYZBVED8Qbkj91chSq7mLz8hW5Pp1DOm7NathsrkyY1DwDi
         4M4olnTgX0OfljdwR4POghXySGUrkSUEeQF4pOY60b5W4+QnlJ5IFdsnE672Oa2Lx9/Y
         Qsew==
X-Gm-Message-State: AOJu0YzczWSBa1giBc6RuWM3UmqakcZkM8HLK1lZSxlEqjatzykVGcVK
	qZXEKLk8ZFWkmAFudHULJHBvLQb7c+2ohBUORmzzysl7yAdwC4Mc6RM5+GHOA1Y=
X-Gm-Gg: ASbGncuW5kDL5UNvw0Yh7c66fBDUQ0fwKLh4BcdDelY8lLJNXGppxn9P2jXW84JUGVT
	71JrUeTrhbj/nm0iMwUjqz4tZjUqr2LzY10febwnyI2IPrh1UBBpnOMahRgOtxyN9VsIcitNIPB
	68Gdgz1IPIAKQ22QY/TOlLW8+sg2FB6KI2Yor9PEouUeRd7v9ovCDb0yscrXSIT/uboHZKUFDSb
	FntUR9XyaRCIGm8oJLQJ7mMgVzyzKRUMHLg0Y5a+Wpy+02e14VYXcb32gUzukuJIUgmQgS02q/3
	hz3NVBWkk5RsSXpJOPDpbU/0pmoNezxr8L/8dfk99NJCt8MYylvF77vaso9M+WV5gzdd0gOlMK2
	kjlw=
X-Google-Smtp-Source: AGHT+IEmWioKfN1n1Pjx9b+0eszvnCyEE1BsNZR7o5QaGQIiHkwCcTSHhVKUgxmQmsZ17x5bMFLYQg==
X-Received: by 2002:a17:902:d4cf:b0:227:ac2a:1dd6 with SMTP id d9443c01a7336-22e1e910446mr168438095ad.24.1746479192001;
        Mon, 05 May 2025 14:06:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::4:906f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fd4fsm59634635ad.146.2025.05.05.14.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 14:06:31 -0700 (PDT)
Message-ID: <a6842c5f-032c-4003-9e7c-2705fecc2835@davidwei.uk>
Date: Mon, 5 May 2025 14:06:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] tools: ynl-gen: split presence metadata
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 jacob.e.keller@intel.com, sdf@fomichev.me
References: <20250505165208.248049-1-kuba@kernel.org>
 <20250505165208.248049-3-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250505165208.248049-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/25 09:52, Jakub Kicinski wrote:
> Each YNL struct contains the data and a sub-struct indicating which
> fields are valid. Something like:
> 
>    struct family_op_req {
>        struct {
>              u32 a:1;
>              u32 b:1;
> 	    u32 bin_len;
>        } _present;
> 
>        u32 a;
>        u64 b;
>        const unsigned char *bin;
>    };
> 
> Note that the bin object 'bin' has a length stored, and that length
> has a _len suffix added to the field name. This breaks if there
> is a explicit field called bin_len, which is the case for some
> TC actions. Move the length fields out of the _present struct,
> create a new struct called _len:
> 
>    struct family_op_req {
>        struct {
>              u32 a:1;
>              u32 b:1;
>        } _present;
>        struct {
> 	    u32 bin;
>        } _len;
> 
>        u32 a;
>        u64 b;
>        const unsigned char *bin;
>    };
> 
> This should prevent name collisions and help with the packing
> of the struct.
> 
> Unfortunately this is a breaking change, but hopefully the migration
> isn't too painful.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   tools/net/ynl/samples/devlink.c  |  2 +-
>   tools/net/ynl/samples/rt-addr.c  |  4 +--
>   tools/net/ynl/samples/rt-route.c |  4 +--
>   tools/net/ynl/pyynl/ynl_gen_c.py | 46 ++++++++++++++++----------------
>   4 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/net/ynl/samples/devlink.c b/tools/net/ynl/samples/devlink.c
> index d2611d7ebab4..3d32a6335044 100644
> --- a/tools/net/ynl/samples/devlink.c
> +++ b/tools/net/ynl/samples/devlink.c
> @@ -34,7 +34,7 @@ int main(int argc, char **argv)
>   		if (!info_rsp)
>   			goto err_free_devs;
>   
> -		if (info_rsp->_present.info_driver_name_len)
> +		if (info_rsp->_len.info_driver_name)
>   			printf("    driver: %s\n", info_rsp->info_driver_name);
>   		if (info_rsp->n_info_version_running)
>   			printf("    running fw:\n");
> diff --git a/tools/net/ynl/samples/rt-addr.c b/tools/net/ynl/samples/rt-addr.c
> index 0f4851b4ec57..2edde5c36b18 100644
> --- a/tools/net/ynl/samples/rt-addr.c
> +++ b/tools/net/ynl/samples/rt-addr.c
> @@ -20,7 +20,7 @@ static void rt_addr_print(struct rt_addr_getaddr_rsp *a)
>   	if (name)
>   		printf("%16s: ", name);
>   
> -	switch (a->_present.address_len) {
> +	switch (a->_len.address) {
>   	case 4:
>   		addr = inet_ntop(AF_INET, a->address,
>   				 addr_str, sizeof(addr_str));
> @@ -36,7 +36,7 @@ static void rt_addr_print(struct rt_addr_getaddr_rsp *a)
>   	if (addr)
>   		printf("%s", addr);
>   	else
> -		printf("[%d]", a->_present.address_len);
> +		printf("[%d]", a->_len.address);
>   
>   	printf("\n");
>   }
> diff --git a/tools/net/ynl/samples/rt-route.c b/tools/net/ynl/samples/rt-route.c
> index 9d9c868f8873..7427104a96df 100644
> --- a/tools/net/ynl/samples/rt-route.c
> +++ b/tools/net/ynl/samples/rt-route.c
> @@ -26,13 +26,13 @@ static void rt_route_print(struct rt_route_getroute_rsp *r)
>   			printf("oif: %-16s ", name);
>   	}
>   
> -	if (r->_present.dst_len) {
> +	if (r->_len.dst) {
>   		route = inet_ntop(r->_hdr.rtm_family, r->dst,
>   				  route_str, sizeof(route_str));
>   		printf("dst: %s/%d", route, r->_hdr.rtm_dst_len);
>   	}
>   
> -	if (r->_present.gateway_len) {
> +	if (r->_len.gateway) {
>   		route = inet_ntop(r->_hdr.rtm_family, r->gateway,
>   				  route_str, sizeof(route_str));
>   		printf("gateway: %s ", route);
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index f93e6e79312a..800710fe96c9 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -154,7 +154,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>   
>           if self.presence_type() == 'len':
>               pfx = '__' if space == 'user' else ''
> -            return f"{pfx}u32 {self.c_name}_len;"
> +            return f"{pfx}u32 {self.c_name};"
>   
>       def _complex_member_type(self, ri):
>           return None
> @@ -217,10 +217,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>           cw.p(f'[{self.enum_name}] = {"{"} .name = "{self.name}", {typol}{"}"},')
>   
>       def _attr_put_line(self, ri, var, line):
> -        if self.presence_type() == 'present':
> -            ri.cw.p(f"if ({var}->_present.{self.c_name})")
> -        elif self.presence_type() == 'len':
> -            ri.cw.p(f"if ({var}->_present.{self.c_name}_len)")
> +        presence = self.presence_type()
> +        if presence in {'present', 'len'}:
> +            ri.cw.p(f"if ({var}->_{presence}.{self.c_name})")
>           ri.cw.p(f"{line};")
>   
>       def _attr_put_simple(self, ri, var, put_type):
> @@ -282,6 +281,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>               # Every layer below last is a nest, so we know it uses bit presence
>               # last layer is "self" and may be a complex type
>               if i == len(ref) - 1 and self.presence_type() != 'present':
> +                presence = f"{var}->{'.'.join(ref[:i] + [''])}_{self.presence_type()}.{ref[i]}"

Can this go a few lines higher and replace:

             presence = f"{var}->{'.'.join(ref[:i] + [''])}_present.{ref[i]}"

Since self.presence_type() would always return the correct string,
including "_present"?

