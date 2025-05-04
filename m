Return-Path: <netdev+bounces-187654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE656AA88F3
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 20:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377513AB142
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388A2288F9;
	Sun,  4 May 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KkhuVBMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E01F2BAE
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383144; cv=none; b=RA0S5lX+6EKLP5rcXjee1IMCTR1gLPVxYgzsreGbeKihyYwJa6oGoQBqpMAtA1mHGctZx7M86Lu43fMbrm4n897T3P8E3rFfIs6pQt7tSet0mBvftIxmOuNM2zEvEeU20yTe3sgVP2tylKbWox8RfvFUtmsHTJ8IR/X5idFPzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383144; c=relaxed/simple;
	bh=rIPDVCgBD98yP8XgkjMd3N9XfKvEAGpKWQd4JOQ4PSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq29UESitv/u6bw2pAFA3Q5WXlvHg+ENy/R/lAj+16S2nTSBDcvjL1wJMhpuna2W+QXgFHPQ7LNsE36jws1c+xJ1AKkT08WGWZlIYWyK0TfDXK1CZUkSDGveRNfhVToske1mxclQRYs12eQsEoFX36M8927979u3kD6E8avur90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KkhuVBMZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a07a7b517dso2248693f8f.3
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746383140; x=1746987940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhDUXZBRLoiL50gX1up2oatHRhRRbdNcpfDcMqnMr/k=;
        b=KkhuVBMZBocTuDfgWv67De3GpoXtrEfbx1JB9towr/ojwUdnHMIKgEEP8XKC9NVaCe
         VB6gEI3MZ9YrKlQhqjhrpvumWBgmGVwvbVQsYmY3LKfKZdyM0+PpPWnyHqGuG0z/tAtw
         tUsfFP1iIVGjD5u2BcPSoQ/47bZXSVNX5H2p7bHRRoYisY2Iu8OjfFO9wVVOx2o1y5Bd
         C6iA3+qOoT7j+p0lpdqyccyt6jufBbk6E0tjOVQh+SVf1QUL/lqsP6EBOyrt46jnACnx
         q0TS5vGT6KH7Ano5sZEpynhqe8iQZ2Ja7MDoxHvsT0ulSe0YDHow7KN9V71oPuuvNY44
         z33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746383140; x=1746987940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhDUXZBRLoiL50gX1up2oatHRhRRbdNcpfDcMqnMr/k=;
        b=wkXwZH3UTFK3jjzH45T6D9n4osITPbfgaf6E1aTarJjIydorfaFOCdB+769o14lgon
         1/OxRqGg3o6Jo5yO3da2eqh3nJC8aYfEbQuPOz7xYWdBwohZWja8b2eNLpYy2yLqjrAQ
         68qQQiZ8GD+itSp4/6sHPFG+wJYYZZrufXOx9wjfKwon+LvmhqcI+KmSiPOoUpvBHE+k
         Hnfbkrqrx0W+fIIi0Vrkz3OexofgGl3YOp/V5pSSzsZQtBNNu2ZHeBRpbu3ccB0tifbq
         5x4xkQjs257tOuaCEOyyLNjaSBIytXm5xPhGCruZaGdnGaB0yXeBKi9r+c5bBT54wzxc
         0SLg==
X-Gm-Message-State: AOJu0YzlSy406S3rLv6l2hn1pXv0sKY0834Dko6gXPrSnVqSOp/+Qw0I
	0wWDsZ4NCA//RMh1AivMGdH3QjS9BIo+0/RhBCcqvizP88gbefZWgHb2Xvkwe48=
X-Gm-Gg: ASbGnctzLEPCjfY/sW1L9ZALkhbrJM7tgjmpfo3L0QZ+6Qzpn5VsQkUc3Z0WNMHA4+v
	gG7/MCwU1xgkAizwwqwz48pAWYh6dgsnmxrLAk1fw+7Jf7CyNI3UCet9oJXWHlNDyoKTDyc7X3V
	NiJybcbvTg6Mf/LUSpDPggab4U9Sy12y3zB5+WAOivuJqVfm2j5jn79GK4u5fsBfW0sS03xLWIm
	CR4rwaF7F2MGsa7iRpE/klyWZEfI2/FcGMb2Hr6wnc35YFKETuLbrLbqMO8vVQKQhYf2xh9EA5y
	ESwTWTe8ZiDn7oWCJTcm006mbBvYsdU856k5zXe2Y0KtFgp7cXpjU/5+YMvvSJPKSjoT
X-Google-Smtp-Source: AGHT+IHBGNRIoR1xwTNw6TYss91GhpHVe0F2QdbxZP4SRvqX6ds09zu6rCGraFNbua8nzaqW1pkkng==
X-Received: by 2002:a05:6000:1863:b0:39c:2c38:4599 with SMTP id ffacd0b85a97d-3a09cf4d6f6mr4417139f8f.48.1746383140300;
        Sun, 04 May 2025 11:25:40 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0b9fsm7868271f8f.4.2025.05.04.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 11:25:39 -0700 (PDT)
Date: Sun, 4 May 2025 20:25:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org, donald.hunter@gmail.com
Subject: Re: [PATCH net-next 2/5] tools: ynl-gen: allow noncontiguous enums
Message-ID: <rgyzpltlodolcgr4pthrq3r2w7s5lj2mutenvszcirpwttmvjq@4dowixxyqxiw>
References: <20250502113821.889-1-jiri@resnulli.us>
 <20250502113821.889-3-jiri@resnulli.us>
 <20250502184347.68488470@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502184347.68488470@kernel.org>

Sat, May 03, 2025 at 03:43:47AM +0200, kuba@kernel.org wrote:
>On Fri,  2 May 2025 13:38:18 +0200 Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> In case the enum has holes, instead of hard stop, generate a validation
>> callback to check valid enum values.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> Saeed's v3->v1:
>> - add validation callback generation
>> ---
>>  tools/net/ynl/pyynl/ynl_gen_c.py | 45 +++++++++++++++++++++++++++++---
>>  1 file changed, 42 insertions(+), 3 deletions(-)
>> 
>> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
>> index b4889974f645..c37551473923 100755
>> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
>> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
>> @@ -358,11 +358,13 @@ class TypeScalar(Type):
>>          if 'enum' in self.attr:
>>              enum = self.family.consts[self.attr['enum']]
>>              low, high = enum.value_range()
>> -            if 'min' not in self.checks:
>> +            if low and 'min' not in self.checks:
>>                  if low != 0 or self.type[0] == 's':
>>                      self.checks['min'] = low
>> -            if 'max' not in self.checks:
>> +            if high and 'max' not in self.checks:
>>                  self.checks['max'] = high
>> +            if not low and not high:
>> +                self.checks['sparse'] = True
>
>you should probably explicitly check for None, 0 is a valid low / high

Okay.


>  
>>          if 'min' in self.checks and 'max' in self.checks:
>>              if self.get_limit('min') > self.get_limit('max'):
>
>> +def print_kernel_policy_sparse_enum_validates(family, cw):
>> +    first = True
>> +    for _, attr_set in family.attr_sets.items():
>> +        if attr_set.subset_of:
>> +            continue
>> +
>> +        for _, attr in attr_set.items():
>> +            if not attr.request:
>> +                continue
>> +            if not attr.enum_name:
>> +                continue
>> +            if 'sparse' not in attr.checks:
>> +                continue
>> +
>> +            if first:
>> +                cw.p('/* Sparse enums validation callbacks */')
>> +                first = False
>> +
>> +            sign = '' if attr.type[0] == 'u' else '_signed'
>> +            suffix = 'ULL' if attr.type[0] == 'u' else 'LL'
>> +            cw.write_func_prot('static int', f'{c_lower(attr.enum_name)}_validate',
>> +                               ['const struct nlattr *attr', 'struct netlink_ext_ack *extack'])
>> +            cw.block_start()
>> +            cw.block_start(line=f'switch (nla_get_{attr["type"]}(attr))', noind=True)
>> +            enum = family.consts[attr['enum']]
>> +            for entry in enum.entries.values():
>> +                cw.p(f'case {entry.c_name}: return 0;')
>
>All the cases end in "return 0;"
>remove this, and add the return 0; before the block end.
>The code should look something like:
>
>	switch (nla_get_...) {
>	case VAL1:
>	case VAL2:
>	case VAL3:
>		return 0;
>	}

Sure.

Thanks!

>
>> +            cw.block_end(noind=True)
>> +            cw.p('NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");')
>> +            cw.p('return -EINVAL;')
>> +            cw.block_end()
>> +            cw.nl()
>> +
>> +
>>  def print_kernel_op_table_fwd(family, cw, terminate):
>>      exported = not kernel_can_gen_family_struct(family)
>>  
>> @@ -2965,6 +3003,7 @@ def main():
>>              print_kernel_family_struct_hdr(parsed, cw)
>>          else:
>>              print_kernel_policy_ranges(parsed, cw)
>> +            print_kernel_policy_sparse_enum_validates(parsed, cw)
>>  
>>              for _, struct in sorted(parsed.pure_nested_structs.items()):
>>                  if struct.request:
>

