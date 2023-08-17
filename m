Return-Path: <netdev+bounces-28377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8EB77F3BF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928241C212FD
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439DE12B6B;
	Thu, 17 Aug 2023 09:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434010786
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:46:11 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D92D57
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:46:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D714B2185A;
	Thu, 17 Aug 2023 09:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692265564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QS1OGhMjIEgil2jkUt/iVaxuAJM4FO9AUrlUEJRg98U=;
	b=Wkc/sE4c0AOrm/iILv02cORr3Ad1Gb/QPnNL3sBa37F60m0DuzkSraKJI44azlZ9eqh86a
	a9dCBzKa0stsitJfXUdIZ0MUIz6f3htr/f/xHBIHvFnX0fuEqbsMhBzo87pzwjSZ5Hvv4N
	OdaAgKYQFVuwvipBKd6wczEv42OafsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692265564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QS1OGhMjIEgil2jkUt/iVaxuAJM4FO9AUrlUEJRg98U=;
	b=CsBoz+wO8epv6R8ys4JzACUMyFBCZhPikqXkquewKIMAjjyI9OUBsDfLEwFBFTcNGTYbf9
	mLTgSEcjV9AGbpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA6181358B;
	Thu, 17 Aug 2023 09:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aD+ZKFzs3WQ+AwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 17 Aug 2023 09:46:04 +0000
Message-ID: <b460dc0c-3254-0c97-557b-3cf42041c247@suse.de>
Date: Thu, 17 Aug 2023 11:46:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-12-hare@suse.de>
 <f250deb1-90d9-f9c4-667f-9e6ad580cb6b@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f250deb1-90d9-f9c4-667f-9e6ad580cb6b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 11:20, Sagi Grimberg wrote:
> 
> 
> On 8/16/23 15:06, Hannes Reinecke wrote:
>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>> referenced keys in the options structure.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/fabrics.c | 52 ++++++++++++++++++++++++++++++++++++-
>>   drivers/nvme/host/fabrics.h |  6 +++++
>>   drivers/nvme/host/tcp.c     | 14 +++++++---
>>   3 files changed, 67 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index ddad482c3537..e453c3871cb1 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -622,6 +622,23 @@ static struct nvmf_transport_ops 
>> *nvmf_lookup_transport(
>>       return NULL;
>>   }
>> +static struct key *nvmf_parse_key(int key_id, char *key_type)
>> +{
>> +    struct key *key;
>> +
>> +    if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>> +        pr_err("TLS is not supported\n");
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>> +    key = key_lookup(key_id);
>> +    if (IS_ERR(key))
>> +        pr_err("%s %08x not found\n", key_type, key_id);
>> +    else
>> +        pr_debug("Using %s %08x\n", key_type, key_id);
> 
> I think that the key_type string is unneeded as an argument solely for
> the log print.
> 
> I think that you can move the error print to the call-site. Keep
> the debug print here, but you don't need the type...
> 
Ok.

>> +    return key;
>> +}
>> +
>>   static const match_table_t opt_tokens = {
>>       { NVMF_OPT_TRANSPORT,        "transport=%s"        },
>>       { NVMF_OPT_TRADDR,        "traddr=%s"        },
>> @@ -643,6 +660,10 @@ static const match_table_t opt_tokens = {
>>       { NVMF_OPT_NR_WRITE_QUEUES,    "nr_write_queues=%d"    },
>>       { NVMF_OPT_NR_POLL_QUEUES,    "nr_poll_queues=%d"    },
>>       { NVMF_OPT_TOS,            "tos=%d"        },
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    { NVMF_OPT_KEYRING,        "keyring=%d"        },
>> +    { NVMF_OPT_TLS_KEY,        "tls_key=%d"        },
>> +#endif
>>       { NVMF_OPT_FAIL_FAST_TMO,    "fast_io_fail_tmo=%d"    },
>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>> @@ -660,9 +681,10 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>       char *options, *o, *p;
>>       int token, ret = 0;
>>       size_t nqnlen  = 0;
>> -    int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
>> +    int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
>>       uuid_t hostid;
>>       char hostnqn[NVMF_NQN_SIZE];
>> +    struct key *key;
>>       /* Set defaults */
>>       opts->queue_size = NVMF_DEF_QUEUE_SIZE;
>> @@ -928,6 +950,32 @@ static int nvmf_parse_options(struct 
>> nvmf_ctrl_options *opts,
>>               }
>>               opts->tos = token;
>>               break;
>> +        case NVMF_OPT_KEYRING:
>> +            if (match_int(args, &key_id) || key_id <= 0) {
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            key = nvmf_parse_key(key_id, "Keyring");
>> +            if (IS_ERR(key)) {
>> +                ret = PTR_ERR(key);
>> +                goto out;
>> +            }
>> +            key_put(opts->keyring);
> 
> Don't understand how keyring/tls_key are pre-populated though...
> 
They are not. But they might, as there's nothing in the code preventing 
the user to specify 'keyring' or 'tls_key' several times.
I can make it one-shot and error out if they are already populated, but
really haven't seen the need.

>> +            opts->keyring = key;
>> +            break;
>> +        case NVMF_OPT_TLS_KEY:
>> +            if (match_int(args, &key_id) || key_id <= 0) {
>> +                ret = -EINVAL;
>> +                goto out;
>> +            }
>> +            key = nvmf_parse_key(key_id, "Key");
>> +            if (IS_ERR(key)) {
>> +                ret = PTR_ERR(key);
>> +                goto out;
>> +            }
>> +            key_put(opts->tls_key);
>> +            opts->tls_key = key;
>> +            break;
>>           case NVMF_OPT_DISCOVERY:
>>               opts->discovery_nqn = true;
>>               break;
>> @@ -1168,6 +1216,8 @@ static int nvmf_check_allowed_opts(struct 
>> nvmf_ctrl_options *opts,
>>   void nvmf_free_options(struct nvmf_ctrl_options *opts)
>>   {
>>       nvmf_host_put(opts->host);
>> +    key_put(opts->keyring);
>> +    key_put(opts->tls_key);
>>       kfree(opts->transport);
>>       kfree(opts->traddr);
>>       kfree(opts->trsvcid);
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index dac17c3fee26..fbaee5a7be19 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -71,6 +71,8 @@ enum {
>>       NVMF_OPT_DHCHAP_SECRET    = 1 << 23,
>>       NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>>       NVMF_OPT_TLS        = 1 << 25,
>> +    NVMF_OPT_KEYRING    = 1 << 26,
>> +    NVMF_OPT_TLS_KEY    = 1 << 27,
>>   };
>>   /**
>> @@ -103,6 +105,8 @@ enum {
>>    * @dhchap_secret: DH-HMAC-CHAP secret
>>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for 
>> bi-directional
>>    *              authentication
>> + * @keyring:    Keyring to use for key lookups
>> + * @tls_key:    TLS key for encrypted connections (TCP)
>>    * @tls:        Start TLS encrypted connections (TCP)
>>    * @disable_sqflow: disable controller sq flow control
>>    * @hdr_digest: generate/verify header digest (TCP)
>> @@ -130,6 +134,8 @@ struct nvmf_ctrl_options {
>>       struct nvmf_host    *host;
>>       char            *dhchap_secret;
>>       char            *dhchap_ctrl_secret;
>> +    struct key        *keyring;
>> +    struct key        *tls_key;
>>       bool            tls;
>>       bool            disable_sqflow;
>>       bool            hdr_digest;
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index ef9cf8c7a113..f48797fcc4ee 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1589,6 +1589,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl 
>> *nctrl,
>>       dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>>           qid, pskid);
>> +    if (nctrl->opts->keyring)
>> +        keyring = key_serial(nctrl->opts->keyring);
> 
> Maybe populate opts->keyring with nvme_keyring_id() to begin
> with and then you don't need this?
> 
We could; one would lose the distinction between 'not specified' and
'specified with the defaul keyring', but one could argue whether that
brings any benefit.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


