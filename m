Return-Path: <netdev+bounces-243444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D6CA1188
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FBDA3007D98
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CD9304BB3;
	Wed,  3 Dec 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmWZPguW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21030AAA6
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786831; cv=none; b=Mfn+/Srk5amsv04HZTjZV2CDFoc/WcEvCo3aBN4aXtDXSZ8H7S/Jc/OB4QBVaMM2v8DGUbGE4/ZN6HAqd9AE1JDNdpC5sc7RvvCnlf5ClpNQlSB3a212mNGcW9uM6ucHbcmu7zO+q4+Uep/PsspBTMgHml14MEe8pmou238IpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786831; c=relaxed/simple;
	bh=5elsAv9mYBEMWdcVwwjN4j79VaD39oi0doEYGtdK1HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qi+gAKl8mRHvNEYL57k3tnBYKL7wIIO5MvB3uSn7WaOb3o9XZDHCxnPqJlzjOzpA3GpvgVfzUJb1uRIUVMZyNpKSULg0rsva1YWZ9DQGXwk3FiNSEzSTxruejT8wYTa5qDKoNjKZZhabnt3je1pEAJcr+OuCRGe2DDiCG0/CL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmWZPguW; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-937262a397eso45922241.1
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 10:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764786827; x=1765391627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XDN7d5gzT6VhLsi2R/9Um8lvzqSinZl76ok+c/8e8c=;
        b=dmWZPguWxMAAKVWFynXeguJmBaDSZDqsHkxdNzjCJ+MCl0w1Z7axco0dWgANODLtf9
         ZcNSs8Iwj7HtLkE4rEJpc6UGNRGtr35/n+PjtMO6q4L0hk+OSmh3b33ejH4eOOGUGuz2
         ipMe4QXRx3oQPkONdAz+X5X34Zb0X28jhcm6WjokLFiOZJAmIfDNBkBWGpMt7xgWnZAt
         9069L3BtrIDqSndlg6AZOYDi5a+xgOTiHdvAIJM/MGAk609IeascHhbxvQpUXt57W3WK
         wsPfrhOKFjLyuU0wITigoX8GU+lCn5RuzSD+Bhgdh6/qgsyODiSC9gm2u6TCFmGw6HSL
         fIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764786827; x=1765391627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XDN7d5gzT6VhLsi2R/9Um8lvzqSinZl76ok+c/8e8c=;
        b=ly5pnlG1FoURgtPq/AHEx+10Yz/WObgji0jdd15Sntismhwp9xR77egDSSHB4MdXm2
         oRWtM4q1S0MJOFAP/4rO6q4keT9tKRAIo7hzHFyXrZvO1zHgyqgv9t6dNnM8JeNzXEPI
         itSPzaNu65iYLow0skmaxYrc+fq6vXrc0ji7Zg/JbM7PPnL2vUlCN29Mq7GlhpE3HjCb
         1g621df9tTQvelzOzB8O+r01AZbJ7dCzRH+iUZ3I3ppfWmjsyfui6K765fsvOtPeXdod
         c3OSBeaWBKL2u1yiNValZSwfQ11p/ARetrm0K7220p0f5Q8NipO9viqGSb4GfTO7JQl3
         Seaw==
X-Forwarded-Encrypted: i=1; AJvYcCUpEnb5rddtw/dQK7YhR9PRy6Thh6LSvVzjqClGUTt3S+cSDEfT7ScBjDQvEnZr8X13I6ILt7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8+nP9a/RDJ6LAQhrMAdCmGFEJOFIBUztLdtOPoPx5ZdVFLm4
	HHv1WpCNWK5BY6eop2jDUSZEHP7rf9dF911N6aoZ12rGtA9coqk2bVzLqa4bUtjqeEP+1WxGYC4
	6BBn+eSSuVoWhCihUB1vpC0qQIhcju2g=
X-Gm-Gg: ASbGncupOPir/GysnlED9yM06kN8HOYYjGVxQl04n7IpfaH6AZQb2cE5mDup5+IZR4Z
	Lohd6dkygYlXvDs3aHSPlfbdwnMSRXRBlKWIcAXNSSZgQ6mmucx8WXCw4zV3qc6p6sI83fR51Sg
	QZe7IVzbVTTHpkBCiuitLB1cQz9jXMbZH9A9lr7lJUaYQ8fY6sWV9wKWYGoZA/NTR56WUOV0Ww5
	Gtt5gv8lBM46S/sV33gzKLVDHuJg6g1l0Z8oVy31OdkHVMMySjQBHVBdypqM7RehA+DxdYrtr7g
	m06inR3BAmGUxafBodxeZfUomjSXnrPoBg==
X-Google-Smtp-Source: AGHT+IFr7ahob4YY4ERT3KPnXPqaAHky/pXrkNT/oVT+2ZNl8DnXv9431n2ejFfMms7S6Ntgjei+tpTwiFlF/ycs5i0=
X-Received: by 2002:a05:6102:15a3:b0:5dd:84f1:b51a with SMTP id
 ada2fe7eead31-5e48e3e3fcemr1145446137.43.1764786826708; Wed, 03 Dec 2025
 10:33:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122003720.16724-1-scott_mitchell@apple.com>
In-Reply-To: <20251122003720.16724-1-scott_mitchell@apple.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 3 Dec 2025 10:33:35 -0800
X-Gm-Features: AWmQ_bn4dMomI8x1tvI4KD8pH7H3osy4RKQpUpSDJ_RRp2F39hNR42_ziIzuWsw
Message-ID: <CAFn2buA9UxAcfrjKk6ty=suHhC3Nr_uGbrD+jb4ZUG2vhWw4NA@mail.gmail.com>
Subject: Re: [PATCH v5] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: pablo@netfilter.org
Cc: kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello folks, friendly ping :) Please let me know if any other changes
are required before merging.

On Fri, Nov 21, 2025 at 4:37=E2=80=AFPM Scott Mitchell <scott.k.mitch1@gmai=
l.com> wrote:
>
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> The current implementation uses a linear list to find queued packets by
> ID when processing verdicts from userspace. With large queue depths and
> out-of-order verdicting, this O(n) lookup becomes a significant
> bottleneck, causing userspace verdict processing to dominate CPU time.
>
> Replace the linear search with a hash table for O(1) average-case
> packet lookup by ID. The hash table size is configurable via the new
> NFQA_CFG_HASH_SIZE netlink attribute (default 1024 buckets, matching
> NFQNL_QMAX_DEFAULT; max 131072). The size is normalized to a power of
> two to enable efficient bitwise masking instead of modulo operations.
> Unpatched kernels silently ignore the new attribute, maintaining
> backward compatibility.
>
> The existing list data structure is retained for operations requiring
> linear iteration (e.g. flush, device down events). Hot fields
> (queue_hash_mask, queue_hash pointer) are placed in the same cache line
> as the spinlock and packet counters for optimal memory access patterns.
>
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> Tested-by: syzbot@syzkaller.appspotmail.com
> ---
> Changes in v5:
> - Use GFP_ATOMIC with kvmalloc_array instead of GFP_KERNEL_ACCOUNT due to
>   rcu_read_lock held in nfqnl_recv_config. Add comment explaining that
>   GFP_KERNEL_ACCOUNT would require lock refactoring (Florian Westphal)
>
> Changes in v4:
> - Fix sleeping while atomic bug: allocate hash table before taking
>   spinlock in instance_create() (syzbot)
>
> Changes in v3:
> - Simplify hash function to use direct masking (id & mask) instead of
>   hash_32() for better cache locality with sequential IDs (Eric Dumazet)
>
> Changes in v2:
> - Use kvcalloc/kvfree with GFP_KERNEL_ACCOUNT to support larger hash
>   tables with vmalloc fallback (Florian Westphal)
> - Remove incorrect comment about concurrent resizes - nfnetlink subsystem
>   mutex already serializes config operations (Florian Westphal)
> - Fix style: remove unnecessary braces around single-line if (Florian Wes=
tphal)
>
>  include/net/netfilter/nf_queue.h              |   1 +
>  .../uapi/linux/netfilter/nfnetlink_queue.h    |   1 +
>  net/netfilter/nfnetlink_queue.c               | 133 ++++++++++++++++--
>  3 files changed, 127 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_=
queue.h
> index 4aeffddb7586..3d0def310523 100644
> --- a/include/net/netfilter/nf_queue.h
> +++ b/include/net/netfilter/nf_queue.h
> @@ -11,6 +11,7 @@
>  /* Each queued (to userspace) skbuff has one of these. */
>  struct nf_queue_entry {
>         struct list_head        list;
> +       struct hlist_node       hash_node;
>         struct sk_buff          *skb;
>         unsigned int            id;
>         unsigned int            hook_index;     /* index in hook_entries-=
>hook[] */
> diff --git a/include/uapi/linux/netfilter/nfnetlink_queue.h b/include/uap=
i/linux/netfilter/nfnetlink_queue.h
> index efcb7c044a74..bc296a17e5aa 100644
> --- a/include/uapi/linux/netfilter/nfnetlink_queue.h
> +++ b/include/uapi/linux/netfilter/nfnetlink_queue.h
> @@ -107,6 +107,7 @@ enum nfqnl_attr_config {
>         NFQA_CFG_QUEUE_MAXLEN,          /* __u32 */
>         NFQA_CFG_MASK,                  /* identify which flags to change=
 */
>         NFQA_CFG_FLAGS,                 /* value of these flags (__u32) *=
/
> +       NFQA_CFG_HASH_SIZE,             /* __u32 hash table size (rounded=
 to power of 2) */
>         __NFQA_CFG_MAX
>  };
>  #define NFQA_CFG_MAX (__NFQA_CFG_MAX-1)
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_qu=
eue.c
> index 8b7b39d8a109..b142fac70ed9 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -46,7 +46,10 @@
>  #include <net/netfilter/nf_conntrack.h>
>  #endif
>
> -#define NFQNL_QMAX_DEFAULT 1024
> +#define NFQNL_QMAX_DEFAULT      1024
> +#define NFQNL_MIN_HASH_SIZE     16
> +#define NFQNL_DEFAULT_HASH_SIZE 1024
> +#define NFQNL_MAX_HASH_SIZE     131072
>
>  /* We're using struct nlattr which has 16bit nla_len. Note that nla_len
>   * includes the header length. Thus, the maximum packet length that we
> @@ -65,6 +68,7 @@ struct nfqnl_instance {
>         unsigned int copy_range;
>         unsigned int queue_dropped;
>         unsigned int queue_user_dropped;
> +       unsigned int queue_hash_size;
>
>
>         u_int16_t queue_num;                    /* number of this queue *=
/
> @@ -77,6 +81,8 @@ struct nfqnl_instance {
>         spinlock_t      lock    ____cacheline_aligned_in_smp;
>         unsigned int    queue_total;
>         unsigned int    id_sequence;            /* 'sequence' of pkt ids =
*/
> +       unsigned int    queue_hash_mask;
> +       struct hlist_head *queue_hash;
>         struct list_head queue_list;            /* packets in queue */
>  };
>
> @@ -95,6 +101,39 @@ static struct nfnl_queue_net *nfnl_queue_pernet(struc=
t net *net)
>         return net_generic(net, nfnl_queue_net_id);
>  }
>
> +static inline unsigned int
> +nfqnl_packet_hash(u32 id, unsigned int mask)
> +{
> +       return id & mask;
> +}
> +
> +static inline u32
> +nfqnl_normalize_hash_size(u32 hash_size)
> +{
> +       /* Must be power of two for queue_hash_mask to work correctly.
> +        * Avoid overflow of is_power_of_2 by bounding NFQNL_MAX_HASH_SIZ=
E.
> +        */
> +       BUILD_BUG_ON(!is_power_of_2(NFQNL_MIN_HASH_SIZE) ||
> +                    !is_power_of_2(NFQNL_DEFAULT_HASH_SIZE) ||
> +                    !is_power_of_2(NFQNL_MAX_HASH_SIZE) ||
> +                    NFQNL_MAX_HASH_SIZE > 1U << 31);
> +
> +       if (!hash_size)
> +               return NFQNL_DEFAULT_HASH_SIZE;
> +
> +       /* Clamp to valid range before power of two to avoid overflow */
> +       if (hash_size <=3D NFQNL_MIN_HASH_SIZE)
> +               return NFQNL_MIN_HASH_SIZE;
> +
> +       if (hash_size >=3D NFQNL_MAX_HASH_SIZE)
> +               return NFQNL_MAX_HASH_SIZE;
> +
> +       if (!is_power_of_2(hash_size))
> +               hash_size =3D roundup_pow_of_two(hash_size);
> +
> +       return hash_size;
> +}
> +
>  static inline u_int8_t instance_hashfn(u_int16_t queue_num)
>  {
>         return ((queue_num >> 8) ^ queue_num) % INSTANCE_BUCKETS;
> @@ -114,13 +153,70 @@ instance_lookup(struct nfnl_queue_net *q, u_int16_t=
 queue_num)
>         return NULL;
>  }
>
> +static int
> +nfqnl_hash_resize(struct nfqnl_instance *inst, u32 hash_size)
> +{
> +       struct hlist_head *new_hash, *old_hash;
> +       struct nf_queue_entry *entry;
> +       unsigned int h, hash_mask;
> +
> +       hash_size =3D nfqnl_normalize_hash_size(hash_size);
> +       if (hash_size =3D=3D inst->queue_hash_size)
> +               return 0;
> +
> +       /* GFP_ATOMIC required: called under rcu_read_lock in nfqnl_recv_=
config.
> +        * Using GFP_KERNEL_ACCOUNT would require refactoring lock placem=
ent.
> +        */
> +       new_hash =3D kvmalloc_array(hash_size, sizeof(*new_hash), GFP_ATO=
MIC);
> +       if (!new_hash)
> +               return -ENOMEM;
> +
> +       hash_mask =3D hash_size - 1;
> +
> +       for (h =3D 0; h < hash_size; h++)
> +               INIT_HLIST_HEAD(&new_hash[h]);
> +
> +       spin_lock_bh(&inst->lock);
> +
> +       list_for_each_entry(entry, &inst->queue_list, list) {
> +               /* No hlist_del() since old_hash will be freed and we hol=
d lock */
> +               h =3D nfqnl_packet_hash(entry->id, hash_mask);
> +               hlist_add_head(&entry->hash_node, &new_hash[h]);
> +       }
> +
> +       old_hash =3D inst->queue_hash;
> +       inst->queue_hash_size =3D hash_size;
> +       inst->queue_hash_mask =3D hash_mask;
> +       inst->queue_hash =3D new_hash;
> +
> +       spin_unlock_bh(&inst->lock);
> +
> +       kvfree(old_hash);
> +
> +       return 0;
> +}
> +
>  static struct nfqnl_instance *
> -instance_create(struct nfnl_queue_net *q, u_int16_t queue_num, u32 porti=
d)
> +instance_create(struct nfnl_queue_net *q, u_int16_t queue_num, u32 porti=
d,
> +               u32 hash_size)
>  {
>         struct nfqnl_instance *inst;
> +       struct hlist_head *queue_hash;
>         unsigned int h;
>         int err;
>
> +       hash_size =3D nfqnl_normalize_hash_size(hash_size);
> +
> +       /* GFP_ATOMIC required: called under rcu_read_lock in nfqnl_recv_=
config.
> +        * Using GFP_KERNEL_ACCOUNT would require refactoring lock placem=
ent.
> +        */
> +       queue_hash =3D kvmalloc_array(hash_size, sizeof(*queue_hash), GFP=
_ATOMIC);
> +       if (!queue_hash)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (h =3D 0; h < hash_size; h++)
> +               INIT_HLIST_HEAD(&queue_hash[h]);
> +
>         spin_lock(&q->instances_lock);
>         if (instance_lookup(q, queue_num)) {
>                 err =3D -EEXIST;
> @@ -133,11 +229,14 @@ instance_create(struct nfnl_queue_net *q, u_int16_t=
 queue_num, u32 portid)
>                 goto out_unlock;
>         }
>
> +       inst->queue_hash =3D queue_hash;
>         inst->queue_num =3D queue_num;
>         inst->peer_portid =3D portid;
>         inst->queue_maxlen =3D NFQNL_QMAX_DEFAULT;
>         inst->copy_range =3D NFQNL_MAX_COPY_RANGE;
>         inst->copy_mode =3D NFQNL_COPY_NONE;
> +       inst->queue_hash_size =3D hash_size;
> +       inst->queue_hash_mask =3D hash_size - 1;
>         spin_lock_init(&inst->lock);
>         INIT_LIST_HEAD(&inst->queue_list);
>
> @@ -157,6 +256,7 @@ instance_create(struct nfnl_queue_net *q, u_int16_t q=
ueue_num, u32 portid)
>         kfree(inst);
>  out_unlock:
>         spin_unlock(&q->instances_lock);
> +       kvfree(queue_hash);
>         return ERR_PTR(err);
>  }
>
> @@ -172,6 +272,7 @@ instance_destroy_rcu(struct rcu_head *head)
>         rcu_read_lock();
>         nfqnl_flush(inst, NULL, 0);
>         rcu_read_unlock();
> +       kvfree(inst->queue_hash);
>         kfree(inst);
>         module_put(THIS_MODULE);
>  }
> @@ -194,13 +295,17 @@ instance_destroy(struct nfnl_queue_net *q, struct n=
fqnl_instance *inst)
>  static inline void
>  __enqueue_entry(struct nfqnl_instance *queue, struct nf_queue_entry *ent=
ry)
>  {
> -       list_add_tail(&entry->list, &queue->queue_list);
> -       queue->queue_total++;
> +       unsigned int hash =3D nfqnl_packet_hash(entry->id, queue->queue_h=
ash_mask);
> +
> +       hlist_add_head(&entry->hash_node, &queue->queue_hash[hash]);
> +       list_add_tail(&entry->list, &queue->queue_list);
> +       queue->queue_total++;
>  }
>
>  static void
>  __dequeue_entry(struct nfqnl_instance *queue, struct nf_queue_entry *ent=
ry)
>  {
> +       hlist_del(&entry->hash_node);
>         list_del(&entry->list);
>         queue->queue_total--;
>  }
> @@ -209,10 +314,11 @@ static struct nf_queue_entry *
>  find_dequeue_entry(struct nfqnl_instance *queue, unsigned int id)
>  {
>         struct nf_queue_entry *entry =3D NULL, *i;
> +       unsigned int hash =3D nfqnl_packet_hash(id, queue->queue_hash_mas=
k);
>
>         spin_lock_bh(&queue->lock);
>
> -       list_for_each_entry(i, &queue->queue_list, list) {
> +       hlist_for_each_entry(i, &queue->queue_hash[hash], hash_node) {
>                 if (i->id =3D=3D id) {
>                         entry =3D i;
>                         break;
> @@ -407,8 +513,7 @@ nfqnl_flush(struct nfqnl_instance *queue, nfqnl_cmpfn=
 cmpfn, unsigned long data)
>         spin_lock_bh(&queue->lock);
>         list_for_each_entry_safe(entry, next, &queue->queue_list, list) {
>                 if (!cmpfn || cmpfn(entry, data)) {
> -                       list_del(&entry->list);
> -                       queue->queue_total--;
> +                       __dequeue_entry(queue, entry);
>                         nfqnl_reinject(entry, NF_DROP);
>                 }
>         }
> @@ -1483,6 +1588,7 @@ static const struct nla_policy nfqa_cfg_policy[NFQA=
_CFG_MAX+1] =3D {
>         [NFQA_CFG_QUEUE_MAXLEN] =3D { .type =3D NLA_U32 },
>         [NFQA_CFG_MASK]         =3D { .type =3D NLA_U32 },
>         [NFQA_CFG_FLAGS]        =3D { .type =3D NLA_U32 },
> +       [NFQA_CFG_HASH_SIZE]    =3D { .type =3D NLA_U32 },
>  };
>
>  static const struct nf_queue_handler nfqh =3D {
> @@ -1495,11 +1601,15 @@ static int nfqnl_recv_config(struct sk_buff *skb,=
 const struct nfnl_info *info,
>  {
>         struct nfnl_queue_net *q =3D nfnl_queue_pernet(info->net);
>         u_int16_t queue_num =3D ntohs(info->nfmsg->res_id);
> +       u32 hash_size =3D 0;
>         struct nfqnl_msg_config_cmd *cmd =3D NULL;
>         struct nfqnl_instance *queue;
>         __u32 flags =3D 0, mask =3D 0;
>         int ret =3D 0;
>
> +       if (nfqa[NFQA_CFG_HASH_SIZE])
> +               hash_size =3D ntohl(nla_get_be32(nfqa[NFQA_CFG_HASH_SIZE]=
));
> +
>         if (nfqa[NFQA_CFG_CMD]) {
>                 cmd =3D nla_data(nfqa[NFQA_CFG_CMD]);
>
> @@ -1559,11 +1669,12 @@ static int nfqnl_recv_config(struct sk_buff *skb,=
 const struct nfnl_info *info,
>                                 goto err_out_unlock;
>                         }
>                         queue =3D instance_create(q, queue_num,
> -                                               NETLINK_CB(skb).portid);
> +                                               NETLINK_CB(skb).portid, h=
ash_size);
>                         if (IS_ERR(queue)) {
>                                 ret =3D PTR_ERR(queue);
>                                 goto err_out_unlock;
>                         }
> +                       hash_size =3D 0; /* avoid resize later in this fu=
nction */
>                         break;
>                 case NFQNL_CFG_CMD_UNBIND:
>                         if (!queue) {
> @@ -1586,6 +1697,12 @@ static int nfqnl_recv_config(struct sk_buff *skb, =
const struct nfnl_info *info,
>                 goto err_out_unlock;
>         }
>
> +       if (hash_size > 0) {
> +               ret =3D nfqnl_hash_resize(queue, hash_size);
> +               if (ret)
> +                       goto err_out_unlock;
> +       }
> +
>         if (nfqa[NFQA_CFG_PARAMS]) {
>                 struct nfqnl_msg_config_params *params =3D
>                         nla_data(nfqa[NFQA_CFG_PARAMS]);
> --
> 2.39.5 (Apple Git-154)
>

