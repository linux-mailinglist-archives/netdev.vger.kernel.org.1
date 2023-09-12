Return-Path: <netdev+bounces-33205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F00779D05A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62314281C4B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149B18030;
	Tue, 12 Sep 2023 11:49:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84215AEE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:49:17 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C183
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:49:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE3A21FD90;
	Tue, 12 Sep 2023 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694519322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOqxfof9/iMnXadLAttyryph9ZtGm9XNUMgeGnNhbI0=;
	b=wEDpjDlpSeE90KIXoetfDYw62tYUuHf5KPhomGN5O1QBeXWKU1lZizX/UGB1LtyinT4IHf
	cCh7H6m//K2DsV56yvAaSTIxQaEhjIcUYGDgQpE3rNjgf1zZfcQnUbNQmvCGZXSVfWBhsM
	7fiJ5hAg+97eFc1wl4d2vZsVdxPgdes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694519322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOqxfof9/iMnXadLAttyryph9ZtGm9XNUMgeGnNhbI0=;
	b=8sFrE4fW0KBrhVJtoW7BeSIRDLgs6U6lcwXRB0v3h5MLveXN3BvQ4YXakArpl8Wj/tPs/v
	xliIxsjMoFnQgwAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B0D5139DB;
	Tue, 12 Sep 2023 11:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PfiOJRpQAGUuAQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 12 Sep 2023 11:48:42 +0000
Message-ID: <94fc9502-c743-4f6c-a082-40e326085426@suse.de>
Date: Tue, 12 Sep 2023 13:48:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-19-hare@suse.de>
 <b545b658-0771-6c53-fc9d-a69e452909c1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b545b658-0771-6c53-fc9d-a69e452909c1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/23 13:32, Sagi Grimberg wrote:
> 
> 
> On 8/24/23 17:39, Hannes Reinecke wrote:
>> Incoming connection might be either 'normal' NVMe-TCP connections
>> starting with icreq or TLS handshakes. To ensure that 'normal'
>> connections can still be handled we need to peek the first packet
>> and only start TLS handshake if it's not an icreq.
>> With that we can lift the restriction to always set TREQ to
>> 'required' when TLS1.3 is enabled.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/configfs.c | 25 +++++++++++---
>>   drivers/nvme/target/nvmet.h    |  5 +++
>>   drivers/nvme/target/tcp.c      | 61 +++++++++++++++++++++++++++++++---
>>   3 files changed, 82 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index b780ce049163..9eed6e6765ea 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -198,6 +198,20 @@ static ssize_t nvmet_addr_treq_store(struct 
>> config_item *item,
>>       return -EINVAL;
>>   found:
>> +    if (port->disc_addr.trtype == NVMF_TRTYPE_TCP &&
>> +        port->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13) {
>> +        switch (nvmet_addr_treq[i].type) {
>> +        case NVMF_TREQ_NOT_SPECIFIED:
>> +            pr_debug("treq '%s' not allowed for TLS1.3\n",
>> +                 nvmet_addr_treq[i].name);
>> +            return -EINVAL;
>> +        case NVMF_TREQ_NOT_REQUIRED:
>> +            pr_warn("Allow non-TLS connections while TLS1.3 is 
>> enabled\n");
>> +            break;
>> +        default:
>> +            break;
>> +        }
>> +    }
>>       treq |= nvmet_addr_treq[i].type;
>>       port->disc_addr.treq = treq;
>>       return count;
>> @@ -410,12 +424,15 @@ static ssize_t nvmet_addr_tsas_store(struct 
>> config_item *item,
>>       nvmet_port_init_tsas_tcp(port, sectype);
>>       /*
>> -     * The TLS implementation currently does not support
>> -     * secure concatenation, so TREQ is always set to 'required'
>> -     * if TLS is enabled.
>> +     * If TLS is enabled TREQ should be set to 'required' per default
>>        */
>>       if (sectype == NVMF_TCP_SECTYPE_TLS13) {
>> -        treq |= NVMF_TREQ_REQUIRED;
>> +        u8 sc = nvmet_port_disc_addr_treq_secure_channel(port);
>> +
>> +        if (sc == NVMF_TREQ_NOT_SPECIFIED)
>> +            treq |= NVMF_TREQ_REQUIRED;
>> +        else
>> +            treq |= sc;
>>       } else {
>>           treq |= NVMF_TREQ_NOT_SPECIFIED;
>>       }
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index e35a03260f45..3e179019ca7c 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -184,6 +184,11 @@ static inline u8 
>> nvmet_port_disc_addr_treq_secure_channel(struct nvmet_port *por
>>       return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
>>   }
>> +static inline bool nvmet_port_secure_channel_required(struct 
>> nvmet_port *port)
>> +{
>> +    return nvmet_port_disc_addr_treq_secure_channel(port) == 
>> NVMF_TREQ_REQUIRED;
>> +}
>> +
>>   struct nvmet_ctrl {
>>       struct nvmet_subsys    *subsys;
>>       struct nvmet_sq        **sqs;
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 67fffa2e1e4a..5c1518a8bded 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1730,6 +1730,54 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>   }
>>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
> 
> You need a stub for the other side of the ifdef?

No. The new function is completely encapsulated by 
CONFIG_NVME_TARGET_TCP_TLS, so no need to add a stub.

Cheers,

Hannes


