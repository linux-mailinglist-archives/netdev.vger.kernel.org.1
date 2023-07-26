Return-Path: <netdev+bounces-21181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2945762B26
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856EE1C210E0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 06:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05366FBC;
	Wed, 26 Jul 2023 06:11:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557179C8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:11:16 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4091995
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:11:14 -0700 (PDT)
Received: from [192.168.1.35] (212-88-24-13.hdsl.highway.telekom.at [212.88.24.13])
	by mail.svario.it (Postfix) with ESMTPSA id C8B56D95AF;
	Wed, 26 Jul 2023 08:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1690351870; bh=zxWmoVbYFXZmrVYUi85uL6I0dd2B6P3kCbTqFNVztHw=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=bSzIbklZ262EBfBQtndPZLPN/iPJ8WcjXZtVKQs8rUOxYPGvMAt7KhxJdbAWrP0n3
	 MQ+v5fftFoMbr0XrIjKEDhcMJbFbfiykmr30dLF37nKVad6fkbhTcmBISztWWGMMAZ
	 Rl2kiZ3myqx+iNGToxcBLMy/TrU+0W+Oj/d9agi48qTUFTnbt+5bMABytWeCHUXRX5
	 W393Ak8Dz0Ix8D51NbXPdgVNSk35lNw/5WSl4MhBun8iFPVtBW/nzBceMgj9C7pe84
	 C10aDrRti4F/gJdJJFvW0CHkS48FLp4AGXHZvxWa8lYjOzQRpLLh1NLu5+4qvKKz4n
	 3raQ0HHEF6xdA==
Message-ID: <44288e78-ad7c-c0ff-703b-f6b733e4f68e@svario.it>
Date: Wed, 26 Jul 2023 08:11:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20230725142759.169725-1-gioele@svario.it>
 <20230725110146.26584f9a@hermes.local>
Content-Language: en-US
From: Gioele Barabucci <gioele@svario.it>
Subject: Re: [iproute2 v3] Read configuration files from /etc and /usr
In-Reply-To: <20230725110146.26584f9a@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks Stephen for the review, I'll soon send a v4 with the fixes 
discussed below.

On 25/07/23 20:01, Stephen Hemminger wrote:
> On Tue, 25 Jul 2023 16:27:59 +0200
> Gioele Barabucci <gioele@svario.it> wrote:
> 
>> @@ -2924,7 +2926,9 @@ static int bpf_elf_ctx_init(struct bpf_elf_ctx *ctx, const char *pathname,
>>   	}
>>   
>>   	bpf_save_finfo(ctx);
>> -	bpf_hash_init(ctx, CONFDIR "/bpf_pinning");
>> +	ret = bpf_hash_init(ctx, CONF_USR_DIR "/bpf_pinning");
>> +	if (ret == -ENOENT)
>> +		bpf_hash_init(ctx, CONF_ETC_DIR "/bpf_pinning");
>>   
> 
> Luca spotted this one, other places prefer /etc over /use but in BPF it is swapped?

Yeah, that's a mistake. Thanks for spotting it. Fixed.

>> -static void
>> +static int
>>   rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
>>   {
>>   	struct rtnl_hash_entry *entry;
>> @@ -67,14 +69,14 @@ rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
>>   
>>   	fp = fopen(file, "r");
>>   	if (!fp)
>> -		return;
>> +		return -errno;
>>   
>>   	while ((ret = fread_id_name(fp, &id, &namebuf[0]))) {
>>   		if (ret == -1) {
>>   			fprintf(stderr, "Database %s is corrupted at %s\n",
>>   					file, namebuf);
>>   			fclose(fp);
>> -			return;
>> +			return -1;
> 
> Having some errors return -errno and others return -1 is confusing.
> Perhaps -EINVAL?

The code was just relaying the -1 received from fread_id_name, but it 
makes sense to use -EINVAL instead. Changed.


>> +		/* only consider filenames not present in /etc */
>> +		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
>> +		if (lstat(path, &sb) == 0)
>> +			continue;
> 
> Do you want lstat() it will return 0 it is a symlink to non existent target.

Yes, lstat is the right function IMO. Other programs that follow the 
stateless pattern also use lstat. By making a symlink, the sysadmin 
stated their intention to override a setting. The code should fail 
reading the target rather than silently skipping the override.


>> +		/* load the conf file in /etc */
>> +		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
>> +		if (is_tab)
>> +			rtnl_tab_initialize(path, (char**)tabhash, size);
>> +		else
>> +			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
> 
> I would prefer that generic function not loose all type information.
> Maybe using a union for the two possible usages? Or type specific callback instead of is_tab.

Makes sense. Changed to use a enum/union.


 >> +	/* load /usr/lib/iproute2/foo.d/X conf files, unless 
/etc/iproute2/foo.d/X exists */
 >> +	d = opendir(dirpath_usr);
 >> +	while (d && (de = readdir(d)) != NULL) {
 >> +		char path[PATH_MAX];
 >> +		size_t len;
 >> +		struct stat sb;
 >> +
 >> +		if (*de->d_name == '.')
 >> +			continue;
 >> +
 >> +		/* only consider filenames ending in '.conf' */
 >> +		len = strlen(de->d_name);
 >> +		if (len <= 5)
 >> +			continue;
 >> +		if (strcmp(de->d_name + len - 5, ".conf"))
 >> +			continue;
 >> +
 >> +		/* only consider filenames not present in /etc */
 >> +		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
 >> +		if (lstat(path, &sb) == 0)
 >> +			continue;
 >> +
 >> +		/* load the conf file in /usr */
 >> +		snprintf(path, sizeof(path), "%s/%s", dirpath_usr, de->d_name);
 >> +		if (is_tab)
 >> +			rtnl_tab_initialize(path, (char**)tabhash, size);
 >> +		else
 >> +			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
 >> +	}
 >> +	if (d)
 >> +		closedir(d);
 >> +
 >> +	/* load /etc/iproute2/foo.d/X conf files */
 >> +	d = opendir(dirpath_etc);
 >> +	while (d && (de = readdir(d)) != NULL) {
 >> +		char path[PATH_MAX];
 >> +		size_t len;
 >> +
 >> +		if (*de->d_name == '.')
 >> +			continue;
 >> +
 >> +		/* only consider filenames ending in '.conf' */
 >> +		len = strlen(de->d_name);
 >> +		if (len <= 5)
 >> +			continue;
 >> +		if (strcmp(de->d_name + len - 5, ".conf"))
 >> +			continue;
 >> +
 >> +		/* load the conf file in /etc */
 >> +		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
 >> +		if (is_tab)
 >> +			rtnl_tab_initialize(path, (char**)tabhash, size);
 >> +		else
 >> +			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
 >> +	}
 >> +	if (d)
 >> +		closedir(d);
 >
 > Why is code copy/pasted here instead of making a function?

Because it deals with different paths in slightly different ways, has 
different comments, and is only a few lines long, so an extra level of 
indirection may be excessive.

However I see your point and I have extracted the code into a separate 
function in v4.

 > Seems sloppy to me.

BTW, this comment seems a bit unkind, given that the current iproute2 
code carries multiple exact copies of the .d lookup code and this patch 
_reduces_ the amount of duplication.

Regards,

-- 
Gioele Barabucci

