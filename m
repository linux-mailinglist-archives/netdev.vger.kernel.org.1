Return-Path: <netdev+bounces-212319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76EFB1F382
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A101618C1239
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CA27F013;
	Sat,  9 Aug 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VCCEzvVv"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3FE19ABDE;
	Sat,  9 Aug 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754730810; cv=none; b=tkmrLhsydmmh5dFTPyOZVc32aEsEvkUd0s6oZSrOiHhCvv7cFmKpbKSkxPUJlZpLaYyFt8GvqeBibrJkVsynEp/ukCbt5c9EhPi2aSFaJrqwF/PutZLX5JOwDNT3JwHHPszNoTCTovVChD1lRMTdKpgPo+lCu4fdUuZbpryOZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754730810; c=relaxed/simple;
	bh=sLFmTatwFr7l5cPHDnYWTzrehQZQLPBOcZpGKNc97us=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMiRYxjZp52+vcOpnCueGqlRdOZILXg1HnXfoFTq2wqNAm374nZ7g8wKmKtMcQVYwGrFPU1IZSdrTqn4d/WbBrHuexW+ru3tnB59Xq7Txs4hTrjDLWtUtQep44vNLFPst7cZL5JlBJkAstXIBJapZzYSWhJnnTfl70q4awbl3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VCCEzvVv; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rR
	lAbYCKdyKBPyABH9sthDYvZeVuJdVFuC6WIkvivI0=; b=VCCEzvVv9WYftXAX6N
	vb/QEKUuZEZWU+UvWvh4MAVEPZFuyzNJN4p6dOy7lAhMsWkMWNIHvoDWbuHHv43+
	s1VDgropsVU28yZxAAY/TrxT/ihdc58gEG3J3KwX4Dyi16Fau1MHRPsrPHolpdy8
	nnDDN98yD7S1NUs1w8yNZxnfA=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHq_x2DZdoreX8Ag--.34476S2;
	Sat, 09 Aug 2025 16:57:27 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
Date: Sat,  9 Aug 2025 16:57:26 +0800
Message-Id: <20250809085726.1482059-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHq_x2DZdoreX8Ag--.34476S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3uFy3GF1fGF4fZw4kJF1rtFb_yoW8Ww18Xo
	Z3XFs8Ga1rKFnrJrW0krs2yF4Uuw1vy3W7Jrs8JrnrW3WSk3y8W3yIkw45Ja13WrWFkF98
	Xa97Gw1avwn8tFZ5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUbzuAUUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibgqjCmiV2OK4lQABsm

On Fri, 2025-08-08 at 19:39 +0800, Ferenc wrote:

> Thanks for the additional details. Out of curiosity, how do your setup looks
> like? The packet received from the LIDAR device are
> A) processed on the system
> B) processed on the system and transmitted elsewhere
> C) only transmitted elsewhere
> 
> From the details provided so far I'm unable to understand the setup you have.
> Both 2ms and 8ms looks pretty high for me. For example on a loaded system, I
> have seen ~200-300us latencies with AF_PACKET software switch P95 with soma rare
> outliers over 1ms. But that system might be faster than a embedded device you
> have.

Dear Ferenc,

The packet received from the LIDAR device are only processed on the system.
The sample code:

#include <arpa/inet.h>
#include <assert.h>
#include <inttypes.h>
#include <linux/filter.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/ip.h>
#include <net/if.h>
#include <netdb.h>
#include <netinet/udp.h>
#include <poll.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <unistd.h>
#include <sstream>
#include <string>
#include <vector>

static const uint16_t kAtxBlockPerPacket = 2U;
static const uint16_t kAtxScanPerBlock = 100;
static const uint16_t kAtxScanPerBlockPed = 36;
static const uint32_t kAtxMaxPointPerScan = 160000U;
static const uint16_t kAtxWheelAngle = 180U;
static const uint16_t kAtxHighAngleUint = 256U;
static const uint16_t kAtxWheelNum = 3U;
static const uint32_t kAtxMaxPkgPerScan = 1800U;
static const float kAtxDistanceMaxMeter = 200.0f;
static const float kAtxDistanceMinMeter = 0.3f;

#pragma pack(push, 1)
struct AtxTail {
  uint8_t status_data[3];
  uint8_t reserved1[7];
  uint8_t parity_flag;  // same as frame_id
  uint8_t reserved2[7];
  int16_t motor_speed;
  uint32_t ts_us;        // ts us parrt
  uint8_t return_mode;   // 0x37  strongest, 0x38 last
  uint8_t factory_info;  // 0x42
  union {
    struct {
      uint8_t reserved4[2];
      uint32_t ts_sec;  // ts sec parrt
    };
    uint8_t ts_utc[6];  // ? virtual time ,not supported currently
  };
  uint32_t udp_seq;
};

struct AtxNetSafty {
  uint8_t signature[32];
};

struct AtxChannel {
  uint16_t distance;
  uint8_t intensity;
  uint8_t confidence;
};

struct AtxBlock {
  // the real azimuth = azimuth / 512
  // low resolution part
  uint16_t azimuth;
  // high resolution part
  uint8_t reserved;
  // AtxChannel channel[kAtxScanPerBlock + kAtxScanPerBlockPed];
  AtxChannel channel[kAtxScanPerBlock];
};

struct AtxDataHeader {
  uint8_t laser_num;
  uint8_t block_num;
  uint8_t first_block_return;
  uint8_t dis_unit;
  uint8_t return_num;
  uint8_t content_flag;
};

struct AtxPkgHeader {
  uint16_t start_flag;
  uint8_t protocol_ver_major;
  uint8_t protocol_ver_minor;
  uint8_t reserved[2];
};

struct AtxDataPkt {
  AtxPkgHeader pkg_header;
  AtxDataHeader data_header;
  AtxBlock blocks[kAtxBlockPerPacket];
  uint32_t crc;
  AtxTail tail;
  char reserved[12];
  AtxNetSafty funcs;
};

// ATX angle correction data
struct PandarATXCorrectionsHeader {
  uint8_t delimiter[2];
  uint8_t version[2];
  uint8_t reserved[2];
  uint8_t channel_quantity;
  uint16_t angle_inv_factor;
};

struct PandarATXCorrections {
  PandarATXCorrectionsHeader header;
  int16_t azimuth_offset[kAtxScanPerBlock];
  int16_t azimuth_offset_odd[kAtxScanPerBlock];
  int16_t elevation[kAtxScanPerBlock];
  uint8_t S56[32];
};
#pragma pack(pop)


struct block_desc {
  uint32_t version;
  uint32_t offset_to_priv;
  struct tpacket_hdr_v1 h1;
};

struct ring {
  struct iovec* rd;
  uint8_t* map;
  struct tpacket_req3 req;
};

static unsigned long packets_total = 0, bytes_total = 0;

std::string GenSockFilterCmd() {
  std::string tcpdump_cmd = "tcpdump -i eth0  host 192.168.1.204 and 'port 10000' -dd";
  return tcpdump_cmd;
}

int32_t GenSockFilterRegisterValue(std::vector<struct sock_filter>& filter_contents) {
  std::string tcpdump_cmd = GenSockFilterCmd();
  std::string result_str(4096u, 0u);
  FILE* fp = popen(tcpdump_cmd.c_str(), "r");
  if (fp == nullptr) {
    printf("exec tcpdump cmd %s fail.", tcpdump_cmd);
    return -1;
  }
  auto read_len = fread((void*)result_str.c_str(), 1u, result_str.size(), fp);
  if (read_len <= 0u || read_len >= result_str.size()) {
    printf("exec tcpdump cmd:%s fail, tcpdump result:%s is invalid.", tcpdump_cmd, read_len);
    pclose(fp);
    return -1;
  }
  pclose(fp);
  std::size_t parsed_index = 0u;
  printf("result_str:%s\n", result_str.c_str());
  while (parsed_index < read_len) {
    std::size_t start_idx = result_str.find('{', parsed_index);
    start_idx += 1u;
    std::size_t end_idx = static_cast<std::size_t>(result_str.find('}', parsed_index));
    if (start_idx == std::string::npos || end_idx == std::string::npos) {
      break;
    }

    auto len = end_idx - start_idx;
    std::istringstream result_is(std::string(result_str.substr(start_idx, len)));

    std::string code, jt, jf, k;
    result_is >> code >> jt >> jf >> k;
    code.erase(code.size() - 1u);
    jt.erase(jt.size() - 1u);
    jf.erase(jf.size() - 1u);
    struct sock_filter filter_content;
    filter_content.code = static_cast<uint16_t>(std::stoi(code, nullptr, 16));
    filter_content.jt = static_cast<uint8_t>(std::stoi(jt));
    filter_content.jf = static_cast<uint8_t>(std::stoi(jf));
    filter_content.k = static_cast<std::size_t>(std::stol(k, nullptr, 16));
    printf("code:%d, jt:%d, jf:%d, k:%lu\n", filter_content.code, filter_content.jt, filter_content.jf, filter_content.k);
    filter_contents.push_back(filter_content);
    parsed_index = end_idx + 1U;
  }
  return 0;
}

static int setup_socket(struct ring* ring, char* netdev) {
  int err, i, fd, v = TPACKET_V3;
  struct sockaddr_ll ll;
  unsigned int blocknum = 64;

  fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
  if (fd < 0) {
    perror("socket");
    exit(1);
  }

  err = setsockopt(fd, SOL_PACKET, PACKET_VERSION, &v, sizeof(v));
  if (err < 0) {
    perror("----setsockopt1");
    exit(1);
  }

  memset(&ring->req, 0, sizeof(ring->req));
  ring->req.tp_block_size = static_cast<uint32_t>(getpagesize());
  ring->req.tp_frame_size = static_cast<uint32_t>(getpagesize());
  ring->req.tp_block_nr = blocknum;
  ring->req.tp_frame_nr = blocknum;
  ring->req.tp_retire_blk_tov = 2;
  ring->req.tp_feature_req_word = TP_FT_REQ_FILL_RXHASH;
  printf("--------pagesize:%d\n", ring->req.tp_block_size);
  err = setsockopt(fd, SOL_PACKET, PACKET_RX_RING, &ring->req, sizeof(ring->req));
  if (err < 0) {
    perror("-----setsockopt2");
    exit(1);
  }

#if 0
  std::vector<struct sock_filter> filter_contents;
  if ((0 == GenSockFilterRegisterValue(filter_contents)) && !filter_contents.empty()) {
    struct sock_fprog bpf_filter;
    bpf_filter.len = static_cast<uint16_t>(filter_contents.size());
    bpf_filter.filter = filter_contents.data();
    if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &bpf_filter, sizeof(bpf_filter)) >= 0) {
    } else {
      printf("attach kernel filter fail and packet filter by user.");
    }
  }
#else
  struct sock_filter code[25] = {
      {0x28, 0, 0, 0x0000000c},  {0x15, 0, 22, 0x00000800}, {0x20, 0, 0, 0x0000001a}, {0x15, 0, 20, 0xc0a801cc},
      {0x30, 0, 0, 0x00000017},  {0x15, 2, 0, 0x00000084},  {0x15, 1, 0, 0x00000006}, {0x15, 0, 16, 0x00000011},
      {0x28, 0, 0, 0x00000014},  {0x45, 14, 0, 0x00001fff}, {0xb1, 0, 0, 0x0000000e}, {0x48, 0, 0, 0x0000000e},
      {0x15, 0, 11, 0x00002710}, {0x20, 0, 0, 0x0000001e},  {0x15, 0, 9, 0xc0a8010a}, {0x30, 0, 0, 0x00000017},
      {0x15, 7, 0, 0x00000084},  {0x15, 6, 0, 0x00000006},  {0x15, 0, 5, 0x00000011}, {0x28, 0, 0, 0x00000014},
      {0x45, 3, 0, 0x00001fff},  {0x48, 0, 0, 0x00000010},  {0x15, 0, 1, 0x000028a2}, {0x6, 0, 0, 0x00040000},
      {0x6, 0, 0, 0x00000000}
  };
  struct sock_fprog bpf_filter;
  bpf_filter.len = static_cast<uint16_t>(25);
  bpf_filter.filter = code;
  setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &bpf_filter, sizeof(bpf_filter));
#endif

  memset(&ll, 0, sizeof(ll));
  ll.sll_family = PF_PACKET;
  ll.sll_protocol = htons(ETH_P_ALL);
  ll.sll_ifindex = if_nametoindex(netdev);
  ll.sll_hatype = 0;
  ll.sll_pkttype = 0;
  ll.sll_halen = 0;

  err = bind(fd, (struct sockaddr*)&ll, sizeof(ll));
  if (err < 0) {
    perror("bind");
    exit(1);
  }

  ring->map = reinterpret_cast<uint8_t*>(mmap(
      NULL, ring->req.tp_block_size * ring->req.tp_block_nr, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_LOCKED, fd, 0));
  if (ring->map == MAP_FAILED) {
    perror("mmap");
    exit(1);
  }

  ring->rd = reinterpret_cast<iovec*>(malloc(ring->req.tp_block_nr * sizeof(*ring->rd)));
  assert(ring->rd);
  for (i = 0; i < ring->req.tp_block_nr; ++i) {
    ring->rd[i].iov_base = ring->map + (i * ring->req.tp_block_size);
    ring->rd[i].iov_len = ring->req.tp_block_size;
  }

  return fd;
}

bool CheckBlockPacketVaild(struct tpacket3_hdr *packet_hdr_ptr) {
  if (packet_hdr_ptr == nullptr) {
    printf("packet_hdr_ptr is nullptr");
    return false;
  }
  {
    struct ethhdr *ethhdr_ptr = (struct ethhdr *)((uint8_t *)packet_hdr_ptr +
                                packet_hdr_ptr->tp_mac);
    if (ethhdr_ptr->h_proto == htons(ETH_P_IP)) {
      struct iphdr *iphdr_ptr = (struct iphdr *)((uint8_t *)ethhdr_ptr +
                                ETH_HLEN);
      char cli_ip[NI_MAXHOST] = {0};
      struct sockaddr_in sockaddr_source;
      memset(&sockaddr_source, 0, sizeof(sockaddr_source));
      sockaddr_source.sin_family = PF_INET;
      sockaddr_source.sin_addr.s_addr = iphdr_ptr->saddr;

      getnameinfo((struct sockaddr *) &sockaddr_source,
                  sizeof(sockaddr_source),
                  cli_ip, sizeof(cli_ip), NULL, 0u, NI_NUMERICHOST);
      if (iphdr_ptr->protocol == IPPROTO_UDP) {
        struct udphdr *udphdr_ptr = (struct udphdr *)((uint8_t *)iphdr_ptr +
                                    sizeof(struct iphdr));
        // printf("port dest:%d, src:%d\n", ntohs(udphdr_ptr->dest), ntohs(udphdr_ptr->source));
        if (ntohs(udphdr_ptr->dest) == 10402 && ntohs(udphdr_ptr->source) == 10000) {
          return true;
        }
      }
    }
    return false;
  }
  return true;
}

union LidarPkgTs {
  uint8_t data[8];
  uint64_t ts{0UL};
};

int64_t GetSensorTimeStamp(const AtxDataPkt &raw_pkg) {
  LidarPkgTs pkg_ts;
  constexpr uint32_t kTimeToUsec = 1000000U;
  if (0 == raw_pkg.tail.ts_utc[0]) {
    pkg_ts.data[7] = 0U;
    pkg_ts.data[6] = 0U;
    pkg_ts.data[5] = 0U;
    pkg_ts.data[4] = 0U;
    pkg_ts.data[3] = raw_pkg.tail.ts_utc[2];
    pkg_ts.data[2] = raw_pkg.tail.ts_utc[3];
    pkg_ts.data[1] = raw_pkg.tail.ts_utc[4];
    pkg_ts.data[0] = raw_pkg.tail.ts_utc[5];
    return static_cast<int64_t>(pkg_ts.ts * kTimeToUsec + raw_pkg.tail.ts_us);
  } else {
    // current using this block
    struct tm point_utctime;
    memset(&point_utctime, 0x00, sizeof(point_utctime));
    point_utctime.tm_year = raw_pkg.tail.ts_utc[0];
    point_utctime.tm_mon = raw_pkg.tail.ts_utc[1] - 1;
    point_utctime.tm_mday = raw_pkg.tail.ts_utc[2];
    point_utctime.tm_hour = raw_pkg.tail.ts_utc[3];
    point_utctime.tm_min = raw_pkg.tail.ts_utc[4];
    point_utctime.tm_sec = raw_pkg.tail.ts_utc[5];
#ifdef WIN
    int64_t utc_ts = _mkgmtime(&point_utctime);
#else
    int64_t utc_ts = timegm(&point_utctime);
#endif
    return (utc_ts * kTimeToUsec + raw_pkg.tail.ts_us);
  }
}

#include <time.h>
#include <stdio.h>

long long get_current_time_us() {
    struct timespec ts;
    clock_gettime(CLOCK_REALTIME, &ts);
    return (long long)ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
}

inline void display(struct tpacket3_hdr* ppd) {
  struct ethhdr* eth = (struct ethhdr*)((uint8_t*)ppd + ppd->tp_mac);
  struct iphdr* ip = (struct iphdr*)((uint8_t*)eth + ETH_HLEN);
  uint32_t header_len = ETH_HLEN + sizeof(iphdr) + sizeof(udphdr);
  static uint32_t g_last_udp_seq{0};
  if (CheckBlockPacketVaild(ppd)) 
  {
    struct sockaddr_in ss, sd;
    char sbuff[NI_MAXHOST], dbuff[NI_MAXHOST];

    memset(&ss, 0, sizeof(ss));
    ss.sin_family = PF_INET;
    ss.sin_addr.s_addr = ip->saddr;
    getnameinfo((struct sockaddr*)&ss, sizeof(ss), sbuff, sizeof(sbuff), NULL, 0, NI_NUMERICHOST);

    memset(&sd, 0, sizeof(sd));
    sd.sin_family = PF_INET;
    sd.sin_addr.s_addr = ip->daddr;
    getnameinfo((struct sockaddr*)&sd, sizeof(sd), dbuff, sizeof(dbuff), NULL, 0, NI_NUMERICHOST);
    uint8_t * tmp_pack_ptr_ = reinterpret_cast<uint8_t *>(ppd) + ppd->tp_mac + header_len;
    AtxDataPkt* tmp_atx_ptr = reinterpret_cast<AtxDataPkt *>(tmp_pack_ptr_);
    size_t pack_size_ = static_cast<size_t>(ppd->tp_snaplen - header_len);
    int64_t tmp_pkt_us = GetSensorTimeStamp(*tmp_atx_ptr);
    //struct timespec ___ts;
    //clock_gettime(CLOCK_REALTIME, &___ts);
    printf(
        "pack_size_:%lu, atx_udp_seq:%u, cur_ts_us:[%llu], cur_pkg_ts_us:[%lu], "
        "delay:%llu\n",
        pack_size_,
        tmp_atx_ptr->tail.udp_seq,
        get_current_time_us(),
        tmp_pkt_us, get_current_time_us() - tmp_pkt_us);
    // printf("%s -> %s, size:%d, udp_seq:%d \n", sbuff, dbuff, pack_size_, tmp_atx_ptr->tail.udp_seq);
    if (0 != g_last_udp_seq && tmp_atx_ptr->tail.udp_seq != g_last_udp_seq + 1) {
      printf("seq loss, last_seq:%u, cur_seq:%u", g_last_udp_seq, tmp_atx_ptr->tail.udp_seq);
    }
    g_last_udp_seq = tmp_atx_ptr->tail.udp_seq;
  }

  // printf("rxhash: 0x%x\n", ppd->hv1.tp_rxhash);
}

inline void walk_block(struct block_desc* pbd, const int block_num) {
  int num_pkts = pbd->h1.num_pkts, i;
  // unsigned long bytes = 0;
  struct tpacket3_hdr* ppd;

  ppd = (struct tpacket3_hdr*)((uint8_t*)pbd + pbd->h1.offset_to_first_pkt);
  printf("--------num_pkts:%d--------\n", num_pkts);
  for (i = 0; i < num_pkts; ++i) {
    // bytes += ppd->tp_snaplen;
    display(ppd);

    ppd = (struct tpacket3_hdr*)((uint8_t*)ppd + ppd->tp_next_offset);
  }

  // packets_total += num_pkts;
  // bytes_total += bytes;
}

static void flush_block(struct block_desc* pbd) {
  pbd->h1.block_status = TP_STATUS_KERNEL;
}

static void teardown_socket(struct ring* ring, int fd) {
  munmap(ring->map, ring->req.tp_block_size * ring->req.tp_block_nr);
  free(ring->rd);
  close(fd);
}

int main(int argc, char** argp) {
  int fd, err;
  socklen_t len;
  struct ring ring;
  struct pollfd pfd;
  unsigned int block_num = 0, blocks = 64;
  struct block_desc* pbd;
  struct tpacket_stats_v3 stats;

  if (argc != 2) {
    fprintf(stderr, "Usage: %s INTERFACE\n", argp[0]);
    return EXIT_FAILURE;
  }

  memset(&ring, 0, sizeof(ring));
  fd = setup_socket(&ring, argp[argc - 1]);
  assert(fd > 0);

  memset(&pfd, 0, sizeof(pfd));
  pfd.fd = fd;
  pfd.events = POLLIN | POLLERR;
  pfd.revents = 0;

  while (1) {
    pbd = (struct block_desc*)ring.rd[block_num].iov_base;

    if ((pbd->h1.block_status & TP_STATUS_USER) == 0) {
      poll(&pfd, 1, -1);
      continue;
    }

    walk_block(pbd, block_num);
    flush_block(pbd);
    block_num = (block_num + 1) % blocks;
  }

  len = sizeof(stats);
  err = getsockopt(fd, SOL_PACKET, PACKET_STATISTICS, &stats, &len);
  if (err < 0) {
    perror("getsockopt");
    exit(1);
  }

  fflush(stdout);
  printf("\nReceived %u packets, %lu bytes, %u dropped, freeze_q_cnt: %u\n",
         stats.tp_packets,
         bytes_total,
         stats.tp_drops,
         stats.tp_freeze_q_cnt);

  teardown_socket(&ring, fd);
  return 0;
}


> From the details provided so far I'm unable to understand the setup you have.
> Both 2ms and 8ms looks pretty high for me. For example on a loaded system, I
> have seen ~200-300us latencies with AF_PACKET software switch P95 with soma rare
> outliers over 1ms. But that system might be faster than a embedded device you
> have.

From my perspective on the implementation of af_packet code, the faster the packets
arrive, the more timely user space can process them, as the block quickly fills up.
However, if the retire timer is still based on jiffies, it remains a significant
issue in systems with CONFIG_HZ_250 or lower. Once packets arrive less frequently
at a certain moment, the existing content in the blk cannot be quickly perceived
and processed by user space. This situation worsens especially in systems configured
with 64k as a page size. We have indeed measured this in our system using sample
program mentioned above.


> These timestamps calculated like this for example?:
> 
> sk = socket(AF_PACKET, ...)
> cur_ts_us = now();
> send(pkt, sk)
> cur_pkg_ts_us = now()

The embedded system we are using has a time synchronization design. The cur_pkg_ts_us
time in the sample, as written in the code above, is the timestamp parsed from the
packet, which is filled in by the LIDAR device when it is sent. The cur_ts_us time
in the sample is the system time obtained from the system. Due to time synchronization,
there will not be a significant discrepancy between the LIDAR time and the system time.



Thanks
Xin Zhao


